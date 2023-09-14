import 'package:chatting/components/CustomTextBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EdiProfilePage extends StatefulWidget {
  const EdiProfilePage({super.key});

  @override
  State<EdiProfilePage> createState() => _EdiProfilePageState();
}

class _EdiProfilePageState extends State<EdiProfilePage> {

  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Edit $field"),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Enter new $field",
        ),
        onChanged: (value) => {
          newValue = value,
        },
      ),
      actions: [
        //cancel button
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),

        //save button
        TextButton(onPressed: () async {
          //update field
          await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).update({
            field: newValue,
          });

          //pop dialog
          Navigator.pop(context);

        }, child: const Text("Save")),

      ],
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(), builder: (context, snapshot){
        if(snapshot.hasData){
          //get user data
          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
        children: [
          const SizedBox(height: 50,),
          //profile picture
          Icon(Icons.person, size: 72,),
          Text(currentUser.email!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 24),),

          const SizedBox(height: 50,),
          const Padding(padding: EdgeInsets.only(left: 25.0), child: Text("My Details",)),

          

          //username
          CustomTextBox(
            text: userData['username'], 
            sectionName: 'Username',
            onPressed: () => editField('username'),
            ),

          //bio
          CustomTextBox(
            text: userData['bio'], 
            sectionName: 'Bio',
            onPressed: () => editField('bio'),
            ),

          //pronouns
          CustomTextBox(
            text: userData['pronouns'], 
            sectionName: 'Pronouns',
            onPressed: () => editField('pronouns'),
            ),

        ],
      );
        } else if (snapshot.hasError){
          return Center(child: Text('Error ${snapshot.error}'),);
        }

        return const Center(child: CircularProgressIndicator(),);
      },)
    );
  }
}