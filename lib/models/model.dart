import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class User {
  User({required this.id, required this.fname, required this.lname, required this.email});
  final String id;
  final String fname;
  final String lname;
  final String email;

  factory User.fromJson(Map<String, dynamic> json){
    return User(id: json['id'],fname: json['fname'], lname: json['lname'], email: json['email']);
  }
}

class Entry {
  Entry({required this.id, required this.dateTime, required this.amount, required this.cause, required this.type, required this.recurring});
  final String id;
  final DateTime dateTime;
  final num amount;
  final String cause;
  final Type type;
  final bool recurring;

  factory Entry.fromJson(Map<String, dynamic> json){
    return Entry(id: json['id'], dateTime: json['dateTime'], amount: json['amount'],cause: json['cause'],
      type: json['type'], recurring: json['recurring']);
  }
}

class MonthlyData {
  MonthlyData({ required this.monthYear, required this.budget, required this.entries});
  final DateTime monthYear;
  final num budget;
  final List<Entry> entries;

  factory MonthlyData.fromJson(Map<String, dynamic> json){
    return MonthlyData(monthYear: json['monthYear'], budget: json['budget'], entries: json['entries']);
  }
}

class Personal {
  Personal({required this.id, required this.user, required this.monthlyData});
  final String id;
  final User user;
  final List<MonthlyData> monthlyData;

  factory Personal.fromJson(Map<String, dynamic> json){
    return Personal(id: json['id'], user: json['user'], monthlyData: json['monthlyData']);
  }
}

class Home {
  Home({ required this.id, required this.user, required this.members, required this.monthlyData});
  final String id;
  final User user;
  final List<User> members;
  final MonthlyData monthlyData;

  factory Home.fromJson(Map<String, dynamic> json){
    return Home(id: json['id'], user: json['user'], members: json['members'], monthlyData: json['monthlyData']);
  }
}

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