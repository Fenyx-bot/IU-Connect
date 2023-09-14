//import 'package:chatting/pages/HomePage.dart';
import 'package:chatting/pages/EditProfilePage.dart';
import 'package:chatting/pages/SettingsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/WallPost.dart';
import '../services/auth/auth_service.dart';
import 'EdiProfilePage.dart';

//import 'FriendsPage.dart';
enum SampleItem { editProfile, settings, signOut }
// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //sign out function
  void signOut() {
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  Map<String, dynamic> data = {
    'uid' : "----",
    'email' : "----",
    'username' : "----",
    "bio" : "----",
    "pronouns" : "----",
  };

  Map<String, dynamic> postData = {
    'UserEmail' : "----",
    'Message' : "----",
    "Timestamp" : "----",
  };

  int postCount = 0;

  //function to get the users data
    getData() async {
    await Future.delayed(const Duration(milliseconds: 5));
    // ignore: use_build_context_synchronously
    showDialog(context: context, builder: (context) =>  const Center(child: CircularProgressIndicator(color: Colors.white,),), barrierDismissible: false,);
    
    // Get docs from collection reference
    DocumentSnapshot document = await FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).get();

    if (document.exists) {
      setState(() {
        data = document.data() as Map<String, dynamic>;
      });
    } else {
      // Document with id == docId doesn't exist.
      data = {
        "username": "error loading data",
        "bio": "error loading data",
        "email": "error loading data",
        "pronouns": "error loading data",
      };
    }

    await FirebaseFirestore.instance.collection('User Posts').where('UserEmail', isEqualTo: _auth.currentUser!.email).get().then((value) => value.docs.forEach((element) {
      setState(() {
        postCount++;
        print(element.data());
        postData = element.data();
      });
    }));

    //pop loading circle
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  SampleItem? selectedMenu;

  @override
  void initState() {
    super.initState();
    getData();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold( key: const Key('profile-page'),
    backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Row(children: [
            const Icon(Icons.person),
            const SizedBox(width: 10,),
            const Center(child: Text('P R O F I L E')),
            const Expanded(child: SizedBox(width: 10,)),
            IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(UID: data["uid"], email: data["email"], username: data["username"], bio: data["bio"], pro: data["pronouns"],)),);}, icon: const Icon(Icons.edit))
        ],
        ),
        ),
        body: Center(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_auth.currentUser!.displayName.toString(), style: TextStyle(fontSize: 20, color: Theme.of(context).appBarTheme.titleTextStyle!.color),),
                    const SizedBox(width: 10,),
                    Text(data["pronouns"], style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.secondary,),),
                  ],
                ),
                Text(_auth.currentUser!.email.toString(), style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.secondary,), ),
                const SizedBox(height: 20,),
                Text("Pins: $postCount \t Friends: 0", style: const TextStyle(fontSize: 20),),
                
                const SizedBox(height: 10,),
                Text(data["bio"], style: const TextStyle(fontSize: 20),),
                const SizedBox(height: 20,),
                const Divider(height: 10, thickness: 1.5, indent: 20, endIndent: 20,color: Colors.black26,),
                const SizedBox(height: 10,),
                const Text("My Pins", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("User Posts").where('UserEmail', isEqualTo: _auth.currentUser!.email).orderBy("Timestamp", descending: true).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(itemCount: postCount ,itemBuilder: (context, index){
                          //get message
                          final post = snapshot.data!.docs[index];
                          return WallPost(message: post["Message"], time: post["Timestamp"].toString(), user: post["Username"], userEmail: post["UserEmail"],postID: post.id, likes: List<String>.from(post['Likes'] ?? []),);
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
              ],
              ),
          ),
    );
  }
}