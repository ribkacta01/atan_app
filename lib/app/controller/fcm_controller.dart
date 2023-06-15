import 'dart:developer';

import 'package:atan_app/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../util/string.dart';

class FCMController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String? adminFCMToken;
  List<String>? jahitFCMToken;
  List<String>? desainFCMToken;
  List<String>? cetakFCMToken;
  List<String>? packingFCMToken;
  Map<String, dynamic>? notificationData;

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
    String email = auth.currentUser!.email!;
    var user = firestore.collection('users').doc(email);

    if (token != null) {
      user.update(
        {'fcmToken': token},
      );
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

    if (message.notification?.title == tambahPemesanTitle) {
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: 'KERANJANG');
      notificationData = message.data;
    } else if (message.notification?.title == tambahTugasTitle) {
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: 'BERANDA');
      notificationData = message.data;
    } else if (message.notification?.title == tambahItemTitle) {
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: 'KERANJANG_BOS');
      notificationData = message.data;
    } else if (message.notification?.title == tambahFotoJahitTitle ||
        message.notification?.title == tambahFotoCetakTitle ||
        message.notification?.title == tambahFotoDesainTitle ||
        message.notification?.title == tambahFotoQAPAckingTitle) {
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: 'BERANDA_BOS');
      notificationData = message.data;
    } else if (message.notification?.title == tugasSelesaiTitle) {
      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: 'BERANDA');
      notificationData = message.data;
    }

    // await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
    //       message.notification?.body, notificationDetails,
    //       );
    //   notificationData = message.data;

    // if (fcmC.notificationData['id'] == berandaView) {
    //   controller.currentIndex2.value = 1;
    // } else if (fcmC.notificationData['id'] == keranjangView) {
    //   controller.currentIndex2.value = 2;
    // }

    // Add your custom logic to handle the message
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    // Handle the incoming message when the app is in the background
    print('Received background message: ${message.notification?.body}');
    // Add your custom logic to handle the message
    if (message != null) {
      notificationData = message.data;
    }
  }

  Future<String?> getAdminToken() async {
    var adminSnapshot = await firestore
        .collection('users')
        .where('divisi', isEqualTo: 'Pemilik Usaha')
        .limit(1)
        .get();
    var adminDoc = adminSnapshot.docs.first;
    if (kDebugMode) {
      print('ADMIN TOKEN EMAIL ${adminDoc.data()['email']}');
    }
    adminFCMToken = adminDoc.data()['fcmToken'];

    return adminFCMToken;
  }

  Future<List<String>> getAllUserToken() async {
    List<String> jahitFCMToken = [];
    var snapshot = await firestore
        .collection('users')
        .where('roles', isEqualTo: 'user')
        .get();
    var document = snapshot.docs;
    for (var doc in document) {
      String token = doc.data()['fcmToken'];
      if (kDebugMode) {
        print('ALL USER TOKEN EMAIL ${doc.data()['email']}');
      }
      jahitFCMToken.add(token);
    }

    return jahitFCMToken;
  }

  Future<List<String>> getJahitToken() async {
    List<String> jahitFCMToken = [];
    var snapshot = await firestore
        .collection('users')
        .where('divisi', isEqualTo: 'Divisi Jahit')
        .get();
    var document = snapshot.docs;
    for (var doc in document) {
      String token = doc.data()['fcmToken'];
      if (kDebugMode) {
        print('JAHIT TOKEN EMAIL ${doc.data()['email']}');
      }
      jahitFCMToken.add(token);
    }

    return jahitFCMToken;
  }

  Future<List<String>> getCetakToken() async {
    List<String> jahitFCMToken = [];
    var snapshot = await firestore
        .collection('users')
        .where('divisi', isEqualTo: 'Divisi Cetak')
        .get();
    var document = snapshot.docs;
    for (var doc in document) {
      String token = doc.data()['fcmToken'];
      if (kDebugMode) {
        print('CETAK TOKEN EMAIL ${doc.data()['email']}');
      }
      jahitFCMToken.add(token);
    }

    return jahitFCMToken;
  }

  Future<List<String>> getDesainToken() async {
    List<String> jahitFCMToken = [];
    var snapshot = await firestore
        .collection('users')
        .where('divisi', isEqualTo: 'Divisi Desain')
        .get();
    var document = snapshot.docs;
    for (var doc in document) {
      String token = doc.data()['fcmToken'];
      if (kDebugMode) {
        print('DESAIN TOKEN EMAIL ${doc.data()['email']}');
      }
      jahitFCMToken.add(token);
    }

    return jahitFCMToken;
  }

  Future<List<String>> getQAPackingToken() async {
    List<String> jahitFCMToken = [];
    var snapshot = await firestore
        .collection('users')
        .where('divisi', isEqualTo: 'Divisi QA & Packing')
        .get();
    var document = snapshot.docs;
    for (var doc in document) {
      String token = doc.data()['fcmToken'];
      if (kDebugMode) {
        print('QA PACKING TOKEN EMAIL ${doc.data()['email']}');
      }
      jahitFCMToken.add(token);
    }

    return jahitFCMToken;
  }
}
