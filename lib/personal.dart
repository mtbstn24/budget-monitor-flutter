import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/auth.dart';
import 'package:firebase_flutter/controllers/methods.dart';
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
  late TextEditingController budgetController;
  num budgetValue = 0;

  @override
  void initState() {
    super.initState();
    budgetController = TextEditingController();
  }

  @override
  void dispose() {
    budgetController.dispose();
    super.dispose();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Text("Cashey", style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic)),
          centerTitle: true,
          title: const Text("Personal Budget"),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 35),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Personal Budget Value",
                                style: TextStyle(fontSize: 12)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('$budgetValue',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            const SizedBox(
                              height: 10,
                              width: 5,
                            ),
                            IconButton(
                              onPressed: () async {
                                final budgetValue = await openDialog(this.budgetValue);
                                if (budgetValue == null ||
                                    budgetValue == 0) return;
                                setState(() {
                                  this.budgetValue = budgetValue;
                                });
                              },
                              icon: const Icon(
                                Icons.edit_rounded,
                                color: Colors.blueGrey,
                                size: 20.0,
                              ),
                            )
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
              getAllEntriePage(),
              const Padding(
                padding: EdgeInsets.all(50),
                child: Text('Signed In to Personal Page'),
              ),
              ElevatedButton(
                onPressed: signOut,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0)),
                child: const Text("Sign Out"),
              ),
            ],
          )),
        ));
  }

  Future<num?> openDialog(value) {
    // setState(() {
    //   budgetController.text = num.parse(value);
    // });
    return showDialog<num>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Enter Details"),
          content: Column(
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Monthly Budget'),
                controller: budgetController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submit(),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: submit,
              child: const Text('SUBMIT'),
            ),
            TextButton(
              onPressed: cancel,
              child: const Text('CANCEL'),
            )
          ],
        ),
      );
  }

  void submit() {
    Navigator.of(context).pop(num.parse(budgetController.text));
  }

  void cancel() {
    Navigator.of(context).pop(this.budgetValue);
  }

  getAllEntriePage(){
    return Column(
          children: [
            const SizedBox(height: 20),
            Card(
              child: Container(
                height: 100,
                color: Colors.blue[50],
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            const Expanded(
                              flex: 5,
                              child: ListTile(
                                title: Text('Rs. 25000'),
                                subtitle: Text("Salary"),
                                leading: Text("Income", style: TextStyle(color: Colors.green),)
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: EdgeInsets.all(5),
                                alignment: Alignment.topRight,
                                child: Text("2022-11-04", style: TextStyle(fontWeight: FontWeight.w500),),
                              ),
                            ),
                             Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      child: const Text("Remove"), onPressed: () {}),
                                  const SizedBox(
                                    width: 8,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 8,
                    ),
                  ],
                ),
              ),
              elevation: 8,
              margin: const EdgeInsets.all(10),
            ),
          ],
        );
  }

}
