// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDLPv9pBBZfoqKRKaI8TjQHzlyNdqYX3sg',
    appId: '1:542959380849:android:6eb48e6c8a90ab019beed0',
    messagingSenderId: '542959380849',
    projectId: 'tugas-akhir-8fdd1',
    storageBucket: 'tugas-akhir-8fdd1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCoRFtXmNCn8vUc7Tr-5ieOdTy84lQg6rw',
    appId: '1:542959380849:ios:dd582b686f024aed9beed0',
    messagingSenderId: '542959380849',
    projectId: 'tugas-akhir-8fdd1',
    storageBucket: 'tugas-akhir-8fdd1.appspot.com',
    androidClientId: '542959380849-ssureptoc60mvictk6sdhnh1seneskuo.apps.googleusercontent.com',
    iosClientId: '542959380849-ede3ivkvgv153ojgs76asuhg4cs8hnu0.apps.googleusercontent.com',
    iosBundleId: 'com.example.atanApp',
  );
}