import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/controllers/methods.dart';
import 'package:flutter/material.dart';
import 'package:firebase_flutter/sample/personal.dart' as personal;
import 'package:firebase_flutter/sample/home.dart' as family;

class EntriesPage extends StatefulWidget {
  const EntriesPage({Key? key}) : super(key: key);

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  final TextEditingController searchController = TextEditingController();
  bool personalStatus = true;
  var entries = [];

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

//function that calls the firebase function used to delete a record
  void removeEntry(id) async{
    deleteEntry(id).then((res) {
      if(res == "success"){
        //renders a message to show the process success
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
      appBar: AppBar(
        leading: const Text("Cashey", style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic)),
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
            Text((personalStatus)? "Personal entries" : "Family entries",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(height: 10),
            StreamBuilder(
              //streambuilder to specify the query and builder used to render the query results
                  stream: FirebaseFirestore.instance
                      .collection('personalData')
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      //widget called until the records are received
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
                                //using conditional statements to change the text color
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
                                    //calls the remove function with the specific record id
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
        )
      ],
      )
    );
  }

  //function returns the button depending on the status value
  getPersonalButton(){
    if(personalStatus){
      setState(() {
        entries = personal.personal;
      });
      return TextButton(onPressed: (){}, child: const Text("Personal"));
    }else{
      return ElevatedButton(onPressed: (){setState(() { personalStatus = true; });}, 
      style: ElevatedButton.styleFrom(primary: Colors.blue[600]), child: const Text("Personal"));
    }
  }

//function returns the button depending on the status value
  getFamilyButton(){
    if(personalStatus){
      return ElevatedButton(onPressed: (){setState(() { personalStatus = false; });}, 
      style: ElevatedButton.styleFrom(primary: Colors.blue[600]), child: const Text("Family"));
    }else{
      setState(() {
        entries = family.home;
      });
      return TextButton(onPressed: (){}, child: const Text("Family"));
    }
  }
}