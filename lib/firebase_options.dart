// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// dart
/// import 'firebase_options.dart';
/// 
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// 
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
    apiKey: 'AIzaSyCaFjzfAMcG_hDI577mM2JAG8W-djlL7to',
    appId: '1:691499025180:web:9d80feea494bfc3a6e30d9',
    messagingSenderId: '691499025180',
    projectId: 'cropdata-fa565',
    authDomain: 'cropdata-fa565.firebaseapp.com',
    storageBucket: 'cropdata-fa565.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBaciCXYjWEdbWH19lBxNOZed27cCQO9aU',
    appId: '1:691499025180:android:220c91151c069c336e30d9',
    messagingSenderId: '691499025180',
    projectId: 'cropdata-fa565',
    storageBucket: 'cropdata-fa565.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB9mCaYBhKBB19xxR8THx7mmRBPxGVwSDA',
    appId: '1:691499025180:ios:cd497efd51d6f3d36e30d9',
    messagingSenderId: '691499025180',
    projectId: 'cropdata-fa565',
    storageBucket: 'cropdata-fa565.appspot.com',
    iosClientId: '691499025180-qfbq9k8qbs8ecljkb4esuk3ebvq315hj.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled',
  );
}
