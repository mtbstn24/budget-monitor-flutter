import 'package:firebase_flutter/pages/addMembers.dart';
import 'package:flutter/material.dart';

class EntriesPage extends StatefulWidget {
  const EntriesPage({Key? key}) : super(key: key);

  @override
  State<EntriesPage> createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
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
        title: const Text('All Entries'),
      ),
      body: Column(
          children: [
            const SizedBox(height: 20),
            Card(
              child: Container(
                height: 120,
                color: const Color.fromARGB(255, 56, 55, 55),
                child: Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Expanded(
                          child: Image.network(
                              'https://www.oberlo.com/media/1605012362-image14.jpg'),
                          flex: 2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            const Expanded(
                              flex: 5,
                              child: ListTile(
                                title: Text('Thushari'),
                                subtitle: Text("0769838892"),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      child: const Text("Select"), onPressed: () {}),
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
}