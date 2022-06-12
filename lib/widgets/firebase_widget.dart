import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olympe/screens/screens.dart';

class FirebaseWidget extends StatelessWidget {
  const FirebaseWidget({Key? key}) : super(key: key);

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const LoginScreen();
              } else {
                return const Text('loading');
              }
            }));
  }
}
