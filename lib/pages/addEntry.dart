import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/controllers/methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class addEntryPage extends StatefulWidget {
  const addEntryPage({Key? key}) : super(key: key);

  @override
  State<addEntryPage> createState() => _addEntryPageState();
}

class _addEntryPageState extends State<addEntryPage> {

  //defining arrays used as drop down items
  List<String> types = ['expense','income'];
  String? type = 'expense';
  List<String> budgetTypes = ['personal','family'];
  String? budgetType ='personal';
  List<String> recurrings = ['recurring','onetime'];
  String? recurring ='onetime';

  //initializing controllers used for monitoring the textfield values
  final TextEditingController _cause = TextEditingController();
  final TextEditingController _amount = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime dateTime = DateTime.now();
  bool showDate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cause.dispose();
    _amount.dispose();
    super.dispose();
  }

  // Date Picker
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }


   String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('MMM d, yyyy').format(selectedDate);
    }
  }


  //Add the new entry
  void saveEntry(){
    bool r =false;
    if(recurring == "onetime"){
      r = false;
    }else{
      r = true;
    }
    
    Future<QuerySnapshot> snap = checkMonthData();
    print(snap);
    //calls the relevant firebase method to create new entry
    addEntry(selectedDate, int.parse(_amount.text), _cause.text, type!, r).then((res) {
      if(res == "success"){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Entry Saved Successfully"),
          ),
        );
      }
    });
    setState(() {
      _cause.text ='';
    });
    setState(() {
      _amount.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: const Text("Cashey", style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic)),
            centerTitle: true,
            title: const Text("Add Entry"),
          ),
          body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownButton<String>(
                focusColor: Colors.white,
                value: budgetType,
                items: budgetTypes.map(
                  (String item){
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }
                ).toList(),
                hint: const Text("Budget Type"),
                onChanged: (item) => setState(() {
                  budgetType = item;
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownButton<String>(
                focusColor: Colors.white,
                value: type,
                items: types.map(
                  (String item){
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }
                ).toList(),
                hint: const Text("Budget Type"),
                onChanged: (item) => setState(() {
                  type = item;
                }),
              ),
            ),
            const SizedBox(height: 24),
            showDate ? Text(getDate()) : const SizedBox(),
            ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                      showDate = true;
                    },
                    child: const Text('Select a Date'),
                  ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                ),
                controller: _amount,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cause',
                ),
                controller: _cause,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownButton<String>(
                focusColor: Colors.white,
                value: recurring,
                items: recurrings.map(
                  (String item){
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }
                ).toList(),
                hint: const Text("Budget Type"),
                onChanged: (item) => setState(() {
                  recurring = item;
                }),
              ),
            ),
            ElevatedButton(
              onPressed: (){saveEntry();}, 
              style: ElevatedButton.styleFrom(primary: Colors.blue[600]), 
              child: const Text("Save")
            ),
          ],
        ),
      )
    )
  );
  }
}
