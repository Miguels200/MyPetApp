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
    apiKey: 'AIzaSyAeDZJu3jFkBLnNFZkikkDdBz_adYwHkP4',
    appId: '1:946165842097:web:8b30c79f39118cafede290',
    messagingSenderId: '946165842097',
    projectId: 'mypetapp-570da',
    authDomain: 'mypetapp-570da.firebaseapp.com',
    storageBucket: 'mypetapp-570da.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClyDcygxKgfcX0SXdX_z_cPbXc3cWggvM',
    appId: '1:946165842097:android:0a61f0a18550a112ede290',
    messagingSenderId: '946165842097',
    projectId: 'mypetapp-570da',
    storageBucket: 'mypetapp-570da.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqReVmgdZ-wdA2GZRIHhaVxNcMr4Eou_M',
    appId: '1:946165842097:ios:019bf268edb658a1ede290',
    messagingSenderId: '946165842097',
    projectId: 'mypetapp-570da',
    storageBucket: 'mypetapp-570da.appspot.com',
    androidClientId: '946165842097-fv844tlkql22sl1bap121s0bo8n1lmjn.apps.googleusercontent.com',
    iosClientId: '946165842097-6ee3mp4iet6nnjl5q6lgk89soofa3pui.apps.googleusercontent.com',
    iosBundleId: 'com.example.mypetapp',
  );
}
