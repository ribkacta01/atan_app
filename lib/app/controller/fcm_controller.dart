import 'dart:developer';

import 'package:atan_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FCMController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String? adminFCMToken;
  List<String>? jahitFCMToken;
  List<String>? desainFCMToken;
  List<String>? cetakFCMToken;
  List<String>? packingFCMToken;

  @override
  Future<void> onInit() async {
    super.onInit();
    firebaseMessaging.requestPermission();
    firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

    String? token = await firebaseMessaging.getToken();
    log('FCM Token: $token');

    if (token != null) {
      String email = auth.currentUser!.email!;
      var user = firestore.collection('users').doc(email);
      user.update({'fcmToken': token});
    }
  }

  Future<void> _handleMessage(RemoteMessage message) async {
    // Handle the incoming message when the app is in the foreground
    print('Received message: ${message.notification?.body}');

    // Display a notification using flutter_local_notifications
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const androidInitializeSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettings =
        InitializationSettings(android: androidInitializeSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
        message.notification?.body, notificationDetails,
        payload: Routes.BERANDA);

    // Add your custom logic to handle the message
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    // Handle the incoming message when the app is in the background
    print('Received background message: ${message.notification?.body}');
    // Add your custom logic to handle the message
  }

  Future<String?> getAdminToken() async {
    if (adminFCMToken == null) {
      var adminSnapshot = await firestore
          .collection('users')
          .where('roles', isEqualTo: 'pemilik_usaha')
          .where('divisi', isEqualTo: 'Pemilik Usaha')
          .get();
      var adminDoc = adminSnapshot.docs.first;
      adminFCMToken = adminDoc.data()['fcmToken'];
    }
    return adminFCMToken;
  }

  Future<List<String>?> getJahitToken() async {
    if (jahitFCMToken == null) {
      var adminSnapshot = await firestore
          .collection('users')
          .where('roles', isEqualTo: 'user')
          .where('divisi', isEqualTo: 'Divisi Jahit')
          .get();
      var adminDoc = adminSnapshot.docs;
      for (var doc in adminDoc) {
        var token = doc.data()['fcmToken'];
        if (token != null) {
          jahitFCMToken!.add(token);
        }
      }
    }
    return jahitFCMToken;
  }
}
