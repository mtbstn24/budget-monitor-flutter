import 'package:firebase_flutter/auth.dart';
import 'package:firebase_flutter/home.dart';
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
          //checks if a user is signed in already
          if(snapshot.hasData){
            print('User Signed In : $snapshot');
            return const HomePage();
          }
          else{
            return const Firebaseauth(); //redirects to the Sign In , Sign Up page
          }
        } 
      );
  }
}