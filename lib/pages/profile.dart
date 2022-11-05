import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: Text("Cashey", style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic)),
            centerTitle: true,
            title: const Text("Profile Details"),
            actions: [
              IconButton(
                onPressed: signOut, 
                icon: const Icon(Icons.logout)
              )
            ],
          ),
          body: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(50),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Text',
                ),
              ),
            ),
          ],
        ),
    ));
  }
}