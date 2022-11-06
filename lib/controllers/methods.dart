import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/models/model.dart';
import 'package:uuid/uuid.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

Future<String> addUserDetails({required String id,
  required String email}) async {
    String res = "Error occured";
    try{
      if(email.isNotEmpty || id.isNotEmpty){
        SystemUser user = SystemUser(id: id, fname: '', lname: '', email: email);
        await _firestore.collection('users').doc(user.id).set(user.toJson());
        res = "success";
      }
    }catch(e){
      res = e.toString();
    }
    return res;
}

String getUserDetails() {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final currentUser = _auth.currentUser!;
  return currentUser.uid;
}

Future<String> editUserDetails(
      String id, String fname, String lname) async {
    String res = "some error occured";
    try {
      _firestore.collection('users').doc(id).set(
          {"fname": fname, "lname": lname},
          SetOptions(merge: true));
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }


Future<String> addEntry(DateTime dateTime, num amount, String cause, String type, bool recurring) async {
  String res = "error occured";
  try {
    String id = const Uuid().v1();
    var userid = getUserDetails();
    print(userid);
    Entry entry = Entry(id: id, userid: userid, dateTime: dateTime, amount: amount, cause: cause, type: type, recurring: recurring);
    print(entry.toJson());
    await _firestore.collection('personalData').doc(id).set(entry.toJson());
    res = "success";
  }catch(e){
    res = e.toString();
  }
  return res;
}

Future<String> deleteEntry(String id) async {
    String res = "some error occured";
    try {
      _firestore.collection('personalData').doc(id).delete();
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }


Future<QuerySnapshot> checkMonthData() async {
  DateTime monthYear = DateTime.now();
  String userid = getUserDetails();

  Future<QuerySnapshot<Map<String, dynamic>>>
    snap = _firestore.collection("personal").where("userid", isEqualTo: userid).where("monthYear", isEqualTo: monthYear).get();
    
    return snap;
}

Future<String> addBudget(num budget) async {
  String res = "error occured";
  try{
    DateTime monthYear = DateTime.now();
    String id = const Uuid().v1();
    String userid = getUserDetails();
    Personal p = Personal(id: id, userid: userid, monthYear: monthYear, budget: budget);
    await _firestore.collection('personal').doc(userid).set(p.toJson());
    res = "success";
  }catch(e){
    res = e.toString();
  }
  return res;
}

Future<String> updateBudget(String id,num budget) async {
  String res = "error occured";
    try {
      // _firestore.collection('personal').doc(id).set(
      //     {"budget": budget},
      //     SetOptions(merge: true));
      print(id + "," + budget.toString());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
}