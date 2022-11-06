import 'package:firebase_flutter/pages/addMembers.dart';
import 'package:flutter/material.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key? key}) : super(key: key);

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        // backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('Family Member'),
        actions: [
          IconButton(
            onPressed: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const AddMemberPage()))}, 
            icon: const Icon(Icons.group_add_rounded),
          )
        ],
      ),
      body: Column(
          children: [
            const SizedBox(height: 20),
            oneMember("Marita Thushari", "thushibstn24@gmail.com"),
            oneMember("Hareen Thushan", "thshnbstn78@gmail.com"),
          ],
        )
    );
  }
}


Widget oneMember(String name, String email){
  return Card(
              elevation: 8,
              margin: const EdgeInsets.all(10),
              child: Container(
                height: 120,
                color: Colors.blue[100],
                child: Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Expanded(
                          flex: 2,
                          child: Image.network(
                              'https://www.oberlo.com/media/1605012362-image14.jpg'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ListTile(
                                title: Text(name),
                                subtitle: Text(email),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
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
                    ),
                  ],
                ),
              ),
            );
}