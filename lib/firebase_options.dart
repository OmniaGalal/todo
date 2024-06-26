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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBXXLO5-lex8bsYrjR8p0i3uegdw7rMg3o',
    appId: '1:408869437527:web:060ad24c5108380319a312',
    messagingSenderId: '408869437527',
    projectId: 'todo-aa14d',
    authDomain: 'todo-aa14d.firebaseapp.com',
    storageBucket: 'todo-aa14d.appspot.com',
    measurementId: 'G-RT2WWXGS4D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkm2o01Icwk-NHGp1xZJvHkS1NnovL0tg',
    appId: '1:408869437527:android:7572a0f0c67d99b219a312',
    messagingSenderId: '408869437527',
    projectId: 'todo-aa14d',
    storageBucket: 'todo-aa14d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBV4lNGHsZmD2c-OKx_aRuUPNEmVzpSfHY',
    appId: '1:408869437527:ios:4d8e32b5c046515119a312',
    messagingSenderId: '408869437527',
    projectId: 'todo-aa14d',
    storageBucket: 'todo-aa14d.appspot.com',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBV4lNGHsZmD2c-OKx_aRuUPNEmVzpSfHY',
    appId: '1:408869437527:ios:4d8e32b5c046515119a312',
    messagingSenderId: '408869437527',
    projectId: 'todo-aa14d',
    storageBucket: 'todo-aa14d.appspot.com',
    iosBundleId: 'com.example.todoapp',
  );
}
