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
        return macos;
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
    apiKey: 'AIzaSyD6qdkokXZNvnnR6eLovkIo1AzMx4Yg_o0',
    appId: '1:350759751615:android:971ed4591a441cfaa19b0a',
    messagingSenderId: '350759751615',
    projectId: 'clinic-949e7',
    storageBucket: 'clinic-949e7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDJ9VHBts7idWv-3d1xRhCxbQsKpsTGtTg',
    appId: '1:350759751615:ios:33505ea272017e63a19b0a',
    messagingSenderId: '350759751615',
    projectId: 'clinic-949e7',
    storageBucket: 'clinic-949e7.appspot.com',
    iosClientId: '350759751615-0b8upubu1a4qkr1kndujd45hf8cm0m9k.apps.googleusercontent.com',
    iosBundleId: 'com.example.clinic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDJ9VHBts7idWv-3d1xRhCxbQsKpsTGtTg',
    appId: '1:350759751615:ios:33505ea272017e63a19b0a',
    messagingSenderId: '350759751615',
    projectId: 'clinic-949e7',
    storageBucket: 'clinic-949e7.appspot.com',
    iosClientId: '350759751615-0b8upubu1a4qkr1kndujd45hf8cm0m9k.apps.googleusercontent.com',
    iosBundleId: 'com.example.clinic',
  );
}