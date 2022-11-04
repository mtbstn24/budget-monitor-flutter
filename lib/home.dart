import 'package:firebase_flutter/family.dart';
import 'package:firebase_flutter/pages/addEntry.dart';
import 'package:firebase_flutter/pages/entries.dart';
import 'package:firebase_flutter/pages/members.dart';
import 'package:firebase_flutter/personal.dart';
import 'package:firebase_flutter/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int pageIndex = 0;

  List <Widget> pages = [
    const PersonalPage(),
    const FamilyPage(),
    const EntriesPage(),
    const ProfilePage(),
    const addEntryPage(),
  ];

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(),
      bottomNavigationBar: getBottomTabBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          selectTab(4);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, size: 25,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
  }

  Widget getPage() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getBottomTabBar() {
    List<IconData> tabBarIcons = [
      Icons.wallet,
      Icons.supervised_user_circle,
      Icons.list_rounded,
      Icons.account_circle
    ];

    return AnimatedBottomNavigationBar(
      icons: tabBarIcons, activeIndex: pageIndex, onTap: (index){ selectTab(index); },
      activeColor: Colors.blue[800], inactiveColor: Colors.blue[100],
      gapLocation: GapLocation.center, notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10, iconSize: 25, rightCornerRadius: 10,
    );
  }

  selectTab(index){
    setState(() {
      pageIndex = index;
    });
  }
}