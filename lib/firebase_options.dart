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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCPRqiVWg76aJX84_NrQHvmlbcHo3ZW0KY',
    appId: '1:418798779462:web:4cfe5ad03d6a384ea15e47',
    messagingSenderId: '418798779462',
    projectId: 'mazad-40394',
    authDomain: 'mazad-40394.firebaseapp.com',
    storageBucket: 'mazad-40394.appspot.com',
    measurementId: 'G-DJBWP6E26S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1yYbc6tHgzvrSMUyOIyBUZmHJraBvqMo',
    appId: '1:418798779462:android:3b11a89f0d8afd92a15e47',
    messagingSenderId: '418798779462',
    projectId: 'mazad-40394',
    storageBucket: 'mazad-40394.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbnZN3P0iBxA6fbSc-lFSfalhaypN7QYs',
    appId: '1:418798779462:ios:01e2573d8b257a57a15e47',
    messagingSenderId: '418798779462',
    projectId: 'mazad-40394',
    storageBucket: 'mazad-40394.appspot.com',
    iosBundleId: 'com.example.mazad',
  );
}
