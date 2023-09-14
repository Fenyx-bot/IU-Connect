import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:chatting/pages/FriendsPage.dart';
import 'package:chatting/pages/HomePage.dart';
import 'package:chatting/pages/ProfilePage.dart';
import 'package:flutter/material.dart';

class NavStateController extends StatefulWidget {
  const NavStateController({super.key});

  @override
  State<NavStateController> createState() => _NavStateControllerState();
}

class _NavStateControllerState extends State<NavStateController> {
  //current index
  int selectedIndex = 0;

  List<Widget> _Pages = [
    HomePage(),
    FriendsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _Pages[selectedIndex],
        bottomNavigationBar: BottomNavyBar(backgroundColor: Theme.of(context).appBarTheme.backgroundColor, selectedIndex: selectedIndex,
          items: [
          BottomNavyBarItem(icon: const Icon(Icons.home), title: const Center(child: Text("Home")), activeColor: Theme.of(context).appBarTheme.iconTheme!.color!, inactiveColor: Colors.grey,),
          BottomNavyBarItem(icon: const Icon(Icons.message), title: const Center(child: Text("Messages")), activeColor: Theme.of(context).appBarTheme.iconTheme!.color!, inactiveColor: Colors.grey,),
          BottomNavyBarItem(icon: const Icon(Icons.person), title: const Center(child: Text("Profile")), activeColor: Theme.of(context).appBarTheme.iconTheme!.color!, inactiveColor: Colors.grey,),
        ], onItemSelected: (index) {
          setState(() {
           selectedIndex = index;
           
          });
        }
        ),
      ),
    );
  }
}