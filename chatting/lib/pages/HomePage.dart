// ignore_for_file: must_be_immutable
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatting/components/CustomTextField.dart';
import 'package:chatting/components/Drawer.dart';
import 'package:chatting/components/WallPost.dart';
import 'package:chatting/pages/FriendsPage.dart';
import 'package:chatting/pages/ProfilePage.dart';
import 'package:chatting/pages/SettingsPage.dart';
import 'package:chatting/services/auth/auth_gate.dart';
import 'package:chatting/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final postController = TextEditingController();



  //add post method
  void addPost(){
    //only post if text field !empty
    if(postController.text.isNotEmpty){
      FirebaseFirestore.instance.collection("User Posts").add({
        'Username' : FirebaseAuth.instance.currentUser!.displayName,
        'UserEmail' : FirebaseAuth.instance.currentUser!.email,
        'Message' : postController.text,
        "Timestamp" : DateTime.now().toString(),
        'Likes' : [],
      });
    }
    //clear text field after posting
    setState(() {
      postController.clear();
    });

  }

  void NavigateToProfilePage(){
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(context, MaterialPageRoute(builder: (context) => (const ProfilePage()),),);
  }

  void NavigateToFriendsPage(){
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(context, MaterialPageRoute(builder: (context) => (const FriendsPage()),),);
  }

  void NavigateToSettingsPage(){
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(context, MaterialPageRoute(builder: (context) => (const SettingsPage()),),);
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Row(children: [
            Icon(Icons.developer_board),
            SizedBox(width: 10,),
            Center(child: Text('T H E \t B O A R D')),
            Expanded(child: SizedBox(width: 10,)),
            /*IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => (const AddPostPage()),),);
            }, icon: const Icon(Icons.post_add),)*/
          ],
        ),
      ),
      drawer: MyDrawer(
        onSFriendsTap: NavigateToFriendsPage,
        onProfileTap: NavigateToProfilePage,
        onSettingsTap: NavigateToSettingsPage,
        onSignOutTap: AuthService().signOut,
      ),
       body: Column(
        children: [
          const SizedBox(height: 15,),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("User Posts").orderBy("Timestamp", descending: true).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(itemCount: snapshot.data!.docs.length ,itemBuilder: (context, index){
                    //get message
                    final post = snapshot.data!.docs[index];
                    return WallPost(
                      message: post["Message"], 
                      time: post["Timestamp"].toString(), 
                      user: post["Username"],
                      userEmail: post["UserEmail"],
                      postID: post.id,
                      likes: List<String>.from(post["Likes"] ?? []),
                      );
                  });
                } 
                else if (snapshot.hasError){
                    return Center(child: Text("Error: ${snapshot.error}"),);
                }
                return const Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              children: [
                Expanded(child: CustomTextField(controller: postController, hintText: "Add a new pin to the board!", obscureText: false)),
                IconButton(onPressed: addPost, icon: Icon(Icons.arrow_circle_up, color: Theme.of(context).appBarTheme.iconTheme!.color!,))
              ],
            ),
          ),
          const SizedBox(height: 15,),
        ],
      ));
  }
}