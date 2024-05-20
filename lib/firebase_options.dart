// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCYN-Dy5O8MMaHP4LyGVJ1JIBr7awq2LdU',
    appId: '1:555707853893:web:815c97927b846603d5472c',
    messagingSenderId: '555707853893',
    projectId: 'weathershare-f5fd3',
    authDomain: 'weathershare-f5fd3.firebaseapp.com',
    storageBucket: 'weathershare-f5fd3.appspot.com',
    measurementId: 'G-GJ4WY0BMMY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKzyO4Wi4_vgA8bMy0biecl_ZAKzKprkc',
    appId: '1:555707853893:android:dd18a5912449d0fdd5472c',
    messagingSenderId: '555707853893',
    projectId: 'weathershare-f5fd3',
    storageBucket: 'weathershare-f5fd3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaoZjgwsYbJmHgXU-xTFntksqWXAufLAo',
    appId: '1:555707853893:ios:8194ecfec0c4cc38d5472c',
    messagingSenderId: '555707853893',
    projectId: 'weathershare-f5fd3',
    storageBucket: 'weathershare-f5fd3.appspot.com',
    iosBundleId: 'com.example.weatherShare',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaoZjgwsYbJmHgXU-xTFntksqWXAufLAo',
    appId: '1:555707853893:ios:8194ecfec0c4cc38d5472c',
    messagingSenderId: '555707853893',
    projectId: 'weathershare-f5fd3',
    storageBucket: 'weathershare-f5fd3.appspot.com',
    iosBundleId: 'com.example.weatherShare',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCYN-Dy5O8MMaHP4LyGVJ1JIBr7awq2LdU',
    appId: '1:555707853893:web:45214e661a974b9cd5472c',
    messagingSenderId: '555707853893',
    projectId: 'weathershare-f5fd3',
    authDomain: 'weathershare-f5fd3.firebaseapp.com',
    storageBucket: 'weathershare-f5fd3.appspot.com',
    measurementId: 'G-R1MTFZXRMY',
  );
}