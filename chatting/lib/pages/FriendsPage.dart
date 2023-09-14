//import 'package:chatting/pages/ProfilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Row(children: [
            const Icon(Icons.people),
            const SizedBox(width: 10,),
            const Center(child: Text('F R I E N D S')),
            const Expanded(child: SizedBox(width: 10,)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.person_add_rounded),)
          ],
        ),
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
    if(_auth.currentUser!.uid != data['uid']){
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5))
          ),
          child:
            ListTile(
          tileColor: Theme.of(context).colorScheme.background,
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(data['username'][0].toUpperCase(), style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color), ),
          ),

          title: Text(data['username']),
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