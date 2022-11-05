import 'package:flutter/material.dart';

class addEntryPage extends StatefulWidget {
  const addEntryPage({Key? key}) : super(key: key);

  @override
  State<addEntryPage> createState() => _addEntryPageState();
}

class _addEntryPageState extends State<addEntryPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: Text("Cashey", style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic)),
            centerTitle: true,
            title: const Text("Add Entry"),
          ),
          body: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(50),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Text',
                ),
              ),
            ),
          ],
        ),
    ));
  }
}
