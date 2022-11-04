import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/auth.dart';
import 'package:firebase_flutter/home.dart';
import 'package:firebase_flutter/personal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            print('User Signed In : $snapshot');
            return const HomePage();
          }
          else{
            return const Firebaseauth();
          }
        } 
      );
  }
}