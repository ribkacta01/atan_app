import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  void subsTopicRoles(String roles) async {
    await FirebaseMessaging.instance.subscribeToTopic(roles);
  }

  void subsTopicDivisi(String divisi) async {
    await FirebaseMessaging.instance.subscribeToTopic(divisi);
  }
}

class NotificationAPI {
  final Dio dio = Dio();

  Future<void> sendNotificationToTopic(
      String topic, String message, String title) async {
    try {
      print('JAJALL');
      final jsonKey =
          await rootBundle.loadString('assets/service_account.json');
      final credentials = json.decode(jsonKey);

      final String projectId = credentials['project_id'];
      final String privateKey = credentials['private_key'];

      final token = await _getAccessToken(projectId, privateKey);

      print(token);

      final data = {
        'message': {
          'topic': topic,
          'notification': {'title': title, 'body': message},
        },
      };

      final response = await dio.post(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('Notification sent. Response: ${response.statusCode}');
    } catch (e) {
      if (e is DioException) {
        print('Request error: $e');
      }
      print('Error sending notification: $e');
    }
  }

  Future<String> _getAccessToken(String projectId, String privateKey) async {
    final response = await dio.post(
      'https://www.googleapis.com/oauth2/v4/token',
      data: {
        'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        'assertion': _generateJwtAssertion(projectId, privateKey),
      },
    );

    if (response.statusCode == 200) {
      final data = response.data;
      return data['access_token'];
    } else {
      throw Exception('Failed to get access token');
    }
  }

  String _generateJwtAssertion(String projectId, String privateKey) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final expiredTime = now + 3600; // Token expiration time: 1 hour

    final header =
        base64Url.encode(json.encode({'alg': 'RS256', 'typ': 'JWT'}).codeUnits);
    final claimSet = base64Url.encode(json.encode({
      'iss': '$projectId@firebase-adminsdk.iam.gserviceaccount.com',
      'scope': 'https://www.googleapis.com/auth/firebase.messaging',
      'aud': 'https://www.googleapis.com/oauth2/v4/token',
      'exp': expiredTime,
      'iat': now,
    }).codeUnits);

    final unsignedToken = '$header.$claimSet';
    final signature = privateKey;

    // Use a library or implementation to sign the unsignedToken with the privateKey
    // and obtain the final assertion.

    return '$unsignedToken.$signature';
  }
}
