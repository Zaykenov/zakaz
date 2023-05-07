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
    apiKey: 'AIzaSyBUF5CUnnWI8KTnW4UegwrVDu44QBf0zyc',
    appId: '1:478711827163:web:5053f052e99a6ed7c79afe',
    messagingSenderId: '478711827163',
    projectId: 'translatorapp-c29e9',
    authDomain: 'translatorapp-c29e9.firebaseapp.com',
    storageBucket: 'translatorapp-c29e9.appspot.com',
    measurementId: 'G-W8X30F26RZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBz37YtbafFAsuQ_mRs8gOiia1vqKKX7cQ',
    appId: '1:478711827163:android:a63448ce1b856671c79afe',
    messagingSenderId: '478711827163',
    projectId: 'translatorapp-c29e9',
    storageBucket: 'translatorapp-c29e9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCsMG5wSLCw8-BVnmJYVYdM7Z59XsPEqXc',
    appId: '1:478711827163:ios:c5bf6594c4cb717ec79afe',
    messagingSenderId: '478711827163',
    projectId: 'translatorapp-c29e9',
    storageBucket: 'translatorapp-c29e9.appspot.com',
    iosClientId: '478711827163-8f276u4cclmi7dfiu5u9vvtbd5u7r7ts.apps.googleusercontent.com',
    iosBundleId: 'com.example.zakazSend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCsMG5wSLCw8-BVnmJYVYdM7Z59XsPEqXc',
    appId: '1:478711827163:ios:c5bf6594c4cb717ec79afe',
    messagingSenderId: '478711827163',
    projectId: 'translatorapp-c29e9',
    storageBucket: 'translatorapp-c29e9.appspot.com',
    iosClientId: '478711827163-8f276u4cclmi7dfiu5u9vvtbd5u7r7ts.apps.googleusercontent.com',
    iosBundleId: 'com.example.zakazSend',
  );
}
