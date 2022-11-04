import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_flutter/family.dart';
import 'package:firebase_flutter/pages/addEntry.dart';
import 'package:firebase_flutter/personal.dart';
import 'package:flutter/material.dart';

List <Widget> pages = [
    const PersonalPage(),
    const FamilyPage(),
    const addEntryPage(),
  ];
  
Widget getBottomTabBar(pageIndex, selectTab) {
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