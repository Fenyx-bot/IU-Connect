//import 'package:chatting/pages/ProfilePage.dart';
import 'package:chatting/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ChatPage.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
  getCurrentIndex(int currentIndex) => _FriendsPageState().getCurrentIndex(currentIndex);
}

class _FriendsPageState extends State<FriendsPage> {
  

  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int idex = 0;
  void getCurrentIndex(int currentIndex){
    idex = currentIndex;
  }

  //sign out function
  void signOut() {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text('IU Friends', style: TextStyle(color: Colors.white),)),
      ),
      body: _buildUserList(),
    );
  }

  //build a list of users except the current user logged in
  Widget _buildUserList(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text('Something went wrong');
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading');
        }

        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      },
    );
  }


  //build a list item for each user
  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all users except for the current user logged in
    if(_auth.currentUser!.email != data['email']){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
        child: ListTile(
          tileColor: Colors.grey[200],
          shape: RoundedRectangleBorder(side: BorderSide(width: 2), borderRadius: BorderRadius.circular(12)),

          title: Center(child: Text(data['username'])),
          onTap: () {
            //pass to the chat page with this current user6
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
              receiverUsername: data['username'],
              receiverUserID: data['uid'],
            ),),);
          },
        ),
      );
    }else{
      //return empty container
      return Container();
    }
  }

}