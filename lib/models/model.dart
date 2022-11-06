import 'package:cloud_firestore/cloud_firestore.dart';

class SystemUser {
  SystemUser({required this.id, required this.fname, required this.lname, required this.email});
  final String id;
  final String fname;
  final String lname;
  final String email;

  factory SystemUser.fromJson(Map<String, dynamic> json){
    return SystemUser(id: json['id'],fname: json['fname'], lname: json['lname'], email: json['email']);
  }

  Map<String, dynamic> toJson() => {
    'id' : id, 'fname' : fname, 'lname' : lname, 'email' : email
  };
}

class Entry {
  Entry({required this.id,required this.userid, required this.dateTime, required this.amount, required this.cause, required this.type, required this.recurring});
  final String id;
  final String userid;
  final DateTime dateTime;
  final num amount;
  final String cause;
  final String type;
  final bool recurring;

  factory Entry.fromJson(Map<String, dynamic> json){
    return Entry( id: json['id'], userid: json['userid'], dateTime: json['dateTime'], amount: json['amount'],cause: json['cause'],
      type: json['type'], recurring: json['recurring']);
  }

  Map<String, dynamic> toJson() => {
    'id':id,'userid':userid, 'dateTime' : dateTime, 'amount' : amount, 'cause' : cause, 'type' : type, 'recurring' : recurring
  };
}

class Personal {
  Personal({required this.id, required this.userid, required this.monthYear, required this.budget,});
  final String id;
  final String userid;
  final DateTime monthYear;
  final num budget;

  factory Personal.fromJson(Map<String, dynamic> json){
    return Personal(id: json['id'], userid: json['userid'], monthYear: json['monthYear'], budget: json['budget'],);
  }

  static Personal fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Personal(
        id: snapshot['id'], userid: snapshot['userid'], monthYear: snapshot['monthYear'], budget: snapshot['budget']);
  }

  Map<String, dynamic> toJson() => {
    'id':id,'userid':userid, 'monthYear' : monthYear, 'budget' : budget,
  };
}

// class Home {
//   Home({ required this.userid, required this.members, required this.monthlyData});
//   final String userid;
//   final List<SystemUser> members;
//   final MonthlyData monthlyData;

//   factory Home.fromJson(Map<String, dynamic> json){
//     return Home(userid: json['userid'], members: json['members'], monthlyData: json['monthlyData']);
//   }
// }

class Recurring {
  Recurring({ required this.id, required this.amount, required this.cause, required this.repeatmode});
  final String id;
  final num amount;
  final String cause;
  final Repeatmode repeatmode;

  factory Recurring.fromJson(Map<String, dynamic> json){
    return Recurring(id: json['id'], amount: json['amount'], cause: json['cause'], repeatmode: json['repeatmode']);
  }
}

class FutureEntry {
  FutureEntry({ required this.id, required this.dateTime, required this.amount, required this.cause});
  final String id;
  final DateTime dateTime;
  final num amount;
  final String cause;

  factory FutureEntry.fromJson(Map<String, dynamic> json){
    return FutureEntry(id: json['id'],dateTime : json['dateTime'], amount: json['amount'], cause: json['cause']);
  }
}

class Alert {
  Alert(this.id, this.userid, this.dateTime, this.message, this.status);
  final String id;
  final String userid;
  final DateTime dateTime;
  final String message;
  final Status status;
}

enum Status {
  pending,
  accessed
}

enum Type {
  expense,
  income
}

enum Repeatmode {
  monthly,
  weekly,
  daily
}