import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/auth.dart';
import 'package:firebase_flutter/home.dart';
import 'package:firebase_flutter/widgets/barChart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:firebase_flutter/widgets/chart.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Personal Budget")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("Personal Budget Plan",
                            style: TextStyle(fontSize: 12)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Monthly",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        SizedBox(
                          height: 10,
                        ),
                      ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Nov" " " "2022",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue)),
                      ]),
                ],
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: chart(),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: barChart(),
          ),
          const Padding(
            padding: EdgeInsets.all(50),
            child: Text('Signed In to Personal Page'),
          ),
          ElevatedButton(
            onPressed: signOut,
            style:
                ElevatedButton.styleFrom(padding: const EdgeInsets.all(20.0)),
            child: const Text("Sign Out"),
          ),
        ],
      )),
    ));
  }
}
