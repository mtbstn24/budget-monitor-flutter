import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/controllers/methods.dart';
import 'package:firebase_flutter/widgets/barChart.dart';
import 'package:flutter/material.dart';
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

  //specified the firebase method to delete an entry
  void removeEntry(id) async{
    deleteEntry(id).then((res) {
      if(res == "success"){
        //displays a message about the process done
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Entry Deleted Successfully"),
          ),
        ); 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const Text("Cashey", style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic)),
          centerTitle: true,
          title: const Text("Personal Budget"),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 35),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('personal')
                      .where("userid",isEqualTo: getUserDetails())
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
              return Column(
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
                            Text(snapshot.data!.docs[0].data()['budget'],
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
                                final budgetValue = await openDialog(snapshot.data!.docs[0].data());
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
            ],);
        })),
        ));
  }


  //returns the dialog box to be poped up
  Future<num?> openDialog(value) {

    //sets the current budget value and controller value
    setState(() {
      budgetValue = int.parse(value['budget']);
    });
    setState(() {
      budgetController.text = value['budget'];
    });

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
                onSubmitted: (_) => submit(value['id']),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed:() {submit(value['id']);},
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

  void submit(id) {
    // updateBudget(id,int.parse(budgetController.text));
    Navigator.of(context).pop(num.parse(budgetController.text));
  }

  void cancel() {
    Navigator.of(context).pop(this.budgetValue);
  }

  //gets all personalData entries from database and display as list view
  getAllEntriePage(){
    return Column(
          children: [
            const SizedBox(height: 20),
            //specifies the query and the builder function to be used to render the data
            StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('personalData')
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
            return ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) => Card(
              elevation: 8,
              margin: const EdgeInsets.all(10),
              child: Container(
                height: 100,
                color: Colors.blue[50],
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ListTile(
                                title: Text(snapshot.data!.docs[index].data()['amount'].toString()),
                                subtitle: Text(snapshot.data!.docs[index].data()['cause']),
                                leading: Text(snapshot.data!.docs[index].data()['type'], 
                                style: TextStyle(color: 
                                (snapshot.data!.docs[index].data()['type']== "expense")?Colors.red
                                : Colors.green),),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                alignment: Alignment.topRight,
                                child: Text((snapshot.data!.docs[index].data()['dateTime'] as Timestamp).toDate().toString().split(' ')[0],
                                 style: const TextStyle(fontWeight: FontWeight.w500),),
                              ),
                            ),
                             Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                      child: const Text("Remove"), 
                                      onPressed: () {removeEntry(snapshot.data!.docs[index].data()['id']);}
                                    ),
                                  const SizedBox(
                                    width: 8,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), 
            separatorBuilder: (BuildContext context, int index)=> const Divider(),
            );
          }
        ),
          ],
        );
  }

}
