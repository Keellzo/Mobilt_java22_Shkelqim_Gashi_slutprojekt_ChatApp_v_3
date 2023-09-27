import 'package:firebase_core/firebase_core.dart';

// Class that holds default Firebase options
class DefaultFirebaseOptions {
  // Private constructor to prevent instantiation from outside
  DefaultFirebaseOptions._();

  // Static constant holding the default Firebase options
  static const FirebaseOptions current = FirebaseOptions(
    apiKey: 'AIzaSyAOi1cD0Dbi8yZkufc3Zw3BfJak0-nIiV4',
    // Firebase API key
    appId: '1:74148999796:android:f69ac0b230169b6ddb9721',
    // Firebase App ID
    messagingSenderId: '74148999796',
    // Firebase Messaging Sender ID
    projectId: 'slutprojekt-cbc8f',
    // Firebase project ID
    storageBucket:
        'slutprojekt-cbc8f.appspot.com', // Firebase storage bucket URL
  );
}
