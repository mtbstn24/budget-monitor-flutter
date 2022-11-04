import 'package:firebase_flutter/landing.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firebase_options.dart';
// import 'auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Landing(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _passsword = TextEditingController();

//   final user = <String, dynamic>{
//     "first": "Ada",
//     "last": "Lovelace",
//     "born": 1815
//   };

//   void uploadData() async {
//     await Firebase.initializeApp();
//     saveData();
//     // print(_name.text);
//   }

//   Future<String> saveData() async {
//     final db = FirebaseFirestore.instance;
//     db.collection("users").add(user).then((DocumentReference doc) => 
//       print('DocumentSnapshot added with ID: ${doc.id}'));
    
//     String res = "success";
//     return res;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(50),
//               child: TextField(
//                 controller: _email,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Email',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(50),
//               child: TextField(
//                 controller: _passsword,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Password',
//                 ),
//               )
//             ),
//             ElevatedButton(
//               onPressed: uploadData,
//               style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20.0)), 
//               child: const Text("Sign Up"),
//             ),
//             ElevatedButton(
//               onPressed: uploadData,
//               style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20.0)), 
//               child: const Text("Sign In"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
