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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_4_qY_mNZDu9L-jkKn6FPJvfCsP3WvtQ',
    appId: '1:893991898029:android:54ad0af8c3dd49268daf24',
    messagingSenderId: '893991898029',
    projectId: 'developistore',
    databaseURL: 'https://developistore.firebaseio.com',
    storageBucket: 'developistore.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDh4itZRiGqkp-TW1k6073PWFhg5pWYWmQ',
    appId: '1:893991898029:ios:32afd89249c8b1f08daf24',
    messagingSenderId: '893991898029',
    projectId: 'developistore',
    databaseURL: 'https://developistore.firebaseio.com',
    storageBucket: 'developistore.appspot.com',
    androidClientId: '893991898029-0bsph7o4nafvsegjnaup1jt5833dljp1.apps.googleusercontent.com',
    iosClientId: '893991898029-0l4bidtv6shrc49a4lguvh7e0c0ml6ei.apps.googleusercontent.com',
    iosBundleId: 'com.fastfill.fastfillstation',
  );
}
