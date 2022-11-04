import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/auth.dart';
import 'package:firebase_flutter/home.dart';
import 'package:firebase_flutter/pages/familyDash.dart';
import 'package:firebase_flutter/pages/members.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FamilyPage extends StatefulWidget {
  const FamilyPage({Key? key}) : super(key: key);

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {

  int fampageIndex = 0;

  List <Widget> fampages = [
    const FamilyDashPage(),
    const MemberPage()
  ];

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Family Budget"),
        actions: [
          IconButton(
            onPressed: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const MemberPage()))}, 
            icon: const Icon(Icons.supervised_user_circle),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(50),
              child: Text('Family Dashboard'),
            ),
            ElevatedButton(
              onPressed: signOut,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20.0)), 
              child: const Text("Sign Out"),
            ),
            ElevatedButton(
              onPressed: ()=>{print("Personal")},
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20.0)), 
              child: const Text("Personal")
            ),
          ],
        )
      ),
      // body: getFamPage(),
    );
  }

  Widget getFamPage() {
    return IndexedStack(
      index: fampageIndex,
      children: fampages,
    );
  }

  selectFamTab(index){
    setState(() {
      fampageIndex = index;
    });
  }
}