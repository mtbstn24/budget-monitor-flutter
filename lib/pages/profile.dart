import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/controllers/methods.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final userid = getUserDetails();

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void updateDetails(id) async{
    editUserDetails(id, _fname.text, _lname.text).then((String res) {
      if(res == "success"){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("User Details Updated Successfully"),
          ),
        ); 
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: Text("Cashey", style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic)),
            centerTitle: true,
            title: const Text("Profile Details"),
            actions: [
              IconButton(
                onPressed: signOut, 
                icon: const Icon(Icons.logout)
              )
            ],
          ),
          body: SingleChildScrollView(
            child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('id',isEqualTo: getUserDetails())
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
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                  ),
                  controller: _fname,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                  ),
                  controller: _lname,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Email : ' + snapshot.data!.docs[0].data()['email']),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                onPressed: (){updateDetails(snapshot.data!.docs[0].data()['id']);}, 
                style: ElevatedButton.styleFrom(primary: Colors.blue[600]), 
                child: const Text("Save")
                ),
              ),
              Card(
              elevation: 8,
              margin: const EdgeInsets.all(10),
              child: Container(
                height: 120,
                color: Colors.blue[100],
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
                                title: const Text('Name'),
                                subtitle: Text(snapshot.data!.docs[0].data()['fname'] 
                                + " " + snapshot.data!.docs[0].data()['lname'] ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(snapshot.data!.docs[0].data()['email'])
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
            ],
            );
            },
          )
          ),
    ));
  }
}