//import 'package:chatting/pages/HomePage.dart';
import 'package:flutter/material.dart';

//import 'FriendsPage.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text('Profile')),
      ),

    );
  }
}