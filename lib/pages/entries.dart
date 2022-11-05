import 'dart:ui';

import 'package:firebase_flutter/pages/addMembers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/sample/personal.dart';

class EntriesPage extends StatefulWidget {
  const EntriesPage({Key? key}) : super(key: key);

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  bool personal = true;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        leading: Text("Cashey", style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic)),
        elevation: 0,
        centerTitle: true,
        title: const Text('All Entries'),
      ),
      body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getPersonalButton(),
                getFamilyButton()
              ],
            ),
            const SizedBox(height: 10),
            Text((personal)? "Personal entries" : "Family entries",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(height: 10),
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
                                title: Text('Rs. 5000'),
                                subtitle: Text("Telephone bill"),
                                leading: Text("Expense", style: TextStyle(color: Colors.red),),
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
        )
    );
  }

  getPersonalButton(){
    if(personal){
      return TextButton(onPressed: (){}, child: const Text("Personal"));
    }else{
      return ElevatedButton(onPressed: (){setState(() { personal = true; });}, child: const Text("Personal"), 
      style: ElevatedButton.styleFrom(primary: Colors.blue[600]));
    }
  }

  getFamilyButton(){
    if(personal){
      return ElevatedButton(onPressed: (){setState(() { personal = false; });}, child: const Text("Family"), 
      style: ElevatedButton.styleFrom(primary: Colors.blue[600]));
    }else{
      return TextButton(onPressed: (){}, child: const Text("Family"));
    }
  }
}