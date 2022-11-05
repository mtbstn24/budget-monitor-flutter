import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/models/model.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

// Future<SystemUser> getUserDetails() async {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//   final currentUser = _auth.currentUser!;
//   // DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
//   print(currentUser);
// }

Future<String> addUserDetails({required String id, required String fname, required String lname,
  required String email}) async {
    String res = "Error occured";
    try{
      if(email.isNotEmpty || id.isNotEmpty || fname.isNotEmpty || lname.isNotEmpty){
        SystemUser user = SystemUser(id: id, fname: fname, lname: lname, email: email);
        await _firestore.collection('users').doc(user.id).set(user.toJson());
        res = "success";
      }
    }catch(e){
      res = e.toString();
    }
    return res;
}

getUserDetails() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final currentUser = _auth.currentUser!;
  // DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
  print(currentUser.uid);
}