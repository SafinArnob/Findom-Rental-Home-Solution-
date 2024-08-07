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
    apiKey: 'AIzaSyBkLoYbBwIaM0LQXQbYGBkxaI2PHzjpdB4',
    appId: '1:1034775586580:web:cab41e0a53037df1b64401',
    messagingSenderId: '1034775586580',
    projectId: 'rental-home-solution',
    authDomain: 'rental-home-solution.firebaseapp.com',
    storageBucket: 'rental-home-solution.appspot.com',
    measurementId: 'G-0K5HLF6QKK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXI6gnOhpmd80yFaJ1agDKamtHPalEHh8',
    appId: '1:1034775586580:android:6454151fc836b7bcb64401',
    messagingSenderId: '1034775586580',
    projectId: 'rental-home-solution',
    storageBucket: 'rental-home-solution.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjhWuaBLvUJijO-wncj3hVieMGK8cBZ8o',
    appId: '1:1034775586580:ios:759f6e9e8dba3dc3b64401',
    messagingSenderId: '1034775586580',
    projectId: 'rental-home-solution',
    storageBucket: 'rental-home-solution.appspot.com',
    iosBundleId: 'com.example.rentalHomeSolution',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjhWuaBLvUJijO-wncj3hVieMGK8cBZ8o',
    appId: '1:1034775586580:ios:759f6e9e8dba3dc3b64401',
    messagingSenderId: '1034775586580',
    projectId: 'rental-home-solution',
    storageBucket: 'rental-home-solution.appspot.com',
    iosBundleId: 'com.example.rentalHomeSolution',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBkLoYbBwIaM0LQXQbYGBkxaI2PHzjpdB4',
    appId: '1:1034775586580:web:013dad8b3b1e2d93b64401',
    messagingSenderId: '1034775586580',
    projectId: 'rental-home-solution',
    authDomain: 'rental-home-solution.firebaseapp.com',
    storageBucket: 'rental-home-solution.appspot.com',
    measurementId: 'G-9Z0JG0YF65',
  );
}
