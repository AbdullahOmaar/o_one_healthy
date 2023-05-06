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
    apiKey: 'AIzaSyCi6chPT1XQq2rihap9ozj8AzAnM69f0h8',
    appId: '1:178835260518:web:0e118019a18bfa38cad9a7',
    messagingSenderId: '178835260518',
    projectId: 'o-one-healthy',
    authDomain: 'o-one-healthy.firebaseapp.com',
    storageBucket: 'o-one-healthy.appspot.com',
    measurementId: 'G-Q90900MN7F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIAYqHOML3erB2tVYqZ5zm1PCKoVsarLc',
    appId: '1:178835260518:android:67390cc480a19b66cad9a7',
    messagingSenderId: '178835260518',
    projectId: 'o-one-healthy',
    storageBucket: 'o-one-healthy.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClD4SiXDC1kFFqYmPu010LSK_9nGStaDk',
    appId: '1:178835260518:ios:e7a98b3670c9f4cdcad9a7',
    messagingSenderId: '178835260518',
    projectId: 'o-one-healthy',
    storageBucket: 'o-one-healthy.appspot.com',
    iosClientId: '178835260518-rb6k6s5k39nbvtjdk1ccn8fu1sgh8lvf.apps.googleusercontent.com',
    iosBundleId: 'com.oonehealthy.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyClD4SiXDC1kFFqYmPu010LSK_9nGStaDk',
    appId: '1:178835260518:ios:e7a98b3670c9f4cdcad9a7',
    messagingSenderId: '178835260518',
    projectId: 'o-one-healthy',
    storageBucket: 'o-one-healthy.appspot.com',
    iosClientId: '178835260518-rb6k6s5k39nbvtjdk1ccn8fu1sgh8lvf.apps.googleusercontent.com',
    iosBundleId: 'com.oonehealthy.app',
  );
}
