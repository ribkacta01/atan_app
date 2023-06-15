import 'dart:developer';

import 'package:atan_app/app/controller/fcm_controller.dart';
import 'package:atan_app/app/util/string.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final fcmC = Get.put(FCMController());

  Future<void> sendNotificationToAdmin(
      String title, String message, String id) async {
    String? userToken = await fcmC.getAdminToken();
    log('ADMIN TOKEN $userToken');

    Dio dio = Dio();
    try {
      Map<String, dynamic> data = {
        'notification': {
          'title': title,
          'body': message,
        },
        'priority': 'high',
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': id,
          'status': 'done',
        },
        'to': userToken,
      };

      Options options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );

      var response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: data,
        options: options,
      );

      if (response.statusCode == 200) {
        // Request successful
        if (kDebugMode) {
          print('Notification sent successfully');
        }
      } else {
        // Request failed
        if (kDebugMode) {
          print(
              'Failed to send notification. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Exception occurred during the request
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
    }
  }

  Future<void> sendNotificationToAllUser(
      String title, String message, String id) async {
    List<String> userToken = await fcmC.getAllUserToken();
    for (var token in userToken) {
      log('USER ALL $token');
    }

    Dio dio = Dio();
    try {
      Map<String, dynamic> data = {
        'notification': {
          'title': title,
          'body': message,
        },
        'priority': 'high',
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': id,
          'status': 'done',
        },
        'registration_ids': userToken,
      };

      Options options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );

      var response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: data,
        options: options,
      );

      if (response.statusCode == 200) {
        // Request successful
        if (kDebugMode) {
          print('Notification sent successfully');
        }
      } else {
        // Request failed
        if (kDebugMode) {
          print(
              'Failed to send notification. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Exception occurred during the request
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
    }
  }

  Future<void> sendNotificationToJahit(
      String title, String message, String id) async {
    List<String> userToken = await fcmC.getJahitToken();
    for (var token in userToken) {
      log('USER JAHIT TOKEN $token');
    }

    Dio dio = Dio();
    try {
      Map<String, dynamic> data = {
        'notification': {
          'title': title,
          'body': message,
        },
        'priority': 'high',
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': id,
          'status': 'done',
        },
        'registration_ids': userToken,
      };

      Options options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );

      var response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: data,
        options: options,
      );

      if (response.statusCode == 200) {
        // Request successful
        if (kDebugMode) {
          print('Notification sent successfully');
        }
      } else {
        // Request failed
        if (kDebugMode) {
          print(
              'Failed to send notification. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Exception occurred during the request
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
    }
  }

  Future<void> sendNotificationToCetak(
      String title, String message, String id) async {
    List<String> userToken = await fcmC.getCetakToken();
    for (var token in userToken) {
      log('USER CETAK TOKEN $token');
    }

    Dio dio = Dio();
    try {
      Map<String, dynamic> data = {
        'notification': {
          'title': title,
          'body': message,
        },
        'priority': 'high',
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': id,
          'status': 'done',
        },
        'registration_ids': userToken,
      };

      Options options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );

      var response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: data,
        options: options,
      );

      if (response.statusCode == 200) {
        // Request successful
        if (kDebugMode) {
          print('Notification sent successfully');
        }
      } else {
        // Request failed
        if (kDebugMode) {
          print(
              'Failed to send notification. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Exception occurred during the request
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
    }
  }

  Future<void> sendNotificationToDesain(
      String title, String message, String id) async {
    List<String> userToken = await fcmC.getDesainToken();
    for (var token in userToken) {
      log('USER DESAIN TOKEN $token');
    }

    Dio dio = Dio();
    try {
      Map<String, dynamic> data = {
        'notification': {
          'title': title,
          'body': message,
        },
        'priority': 'high',
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': id,
          'status': 'done',
        },
        'registration_ids': userToken,
      };

      Options options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );

      var response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: data,
        options: options,
      );

      if (response.statusCode == 200) {
        // Request successful
        if (kDebugMode) {
          print('Notification sent successfully');
        }
      } else {
        // Request failed
        if (kDebugMode) {
          print(
              'Failed to send notification. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Exception occurred during the request
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
    }
  }

  Future<void> sendNotificationToQAPacking(
      String title, String message, String id) async {
    List<String> userToken = await fcmC.getQAPackingToken();
    for (var token in userToken) {
      log('USER QA & PACKING TOKEN $token');
    }

    Dio dio = Dio();
    try {
      Map<String, dynamic> data = {
        'notification': {
          'title': title,
          'body': message,
        },
        'priority': 'high',
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': id,
          'status': 'done',
        },
        'registration_ids': userToken,
      };

      Options options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
      );

      var response = await dio.post(
        'https://fcm.googleapis.com/fcm/send',
        data: data,
        options: options,
      );

      if (response.statusCode == 200) {
        // Request successful
        if (kDebugMode) {
          print('Notification sent successfully');
        }
      } else {
        // Request failed
        if (kDebugMode) {
          print(
              'Failed to send notification. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Exception occurred during the request
      if (kDebugMode) {
        print('Error sending notification: $e');
      }
    }
  }
}
