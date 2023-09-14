import 'package:chatting/components/CustomTextBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth/auth_service.dart';

//import 'FriendsPage.dart';
enum SampleItem { editProfile, settings, signOut }
// ignore: must_be_immutable
class EditProfilePage extends StatefulWidget {
  final String UID;
  final String email;
  String username;
  String bio;
  String pro;
  
  EditProfilePage({super.key, required this.UID, required this.email, required this.username, required this.bio, required this.pro});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final currentUser = FirebaseAuth.instance.currentUser!;

  void updateInfo(){
    if(_usernameController.text == widget.username && _bioController.text == widget.bio && _pronounsController.text == widget.pro){
      Navigator.pop(context);
      return;
    }

     if(_usernameController.text == ""){
      _usernameController.text = widget.username;
    }

     _auth.currentUser!.updateDisplayName(_usernameController.text);
    FirebaseFirestore.instance.collection('users').doc(widget.UID).update({
      'username': _usernameController.text,
      'bio': _bioController.text,
      'pronouns': _pronounsController.text,
    }).then((_) => print("User Updated")).catchError((e) => print("Failed to update user: $e"));
   
    Navigator.pop(context);
  }

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
          if (field == "username"){
            if (newValue == "") {
              newValue = widget.username;
            }
            setState(() {
              _auth.currentUser!.updateDisplayName(newValue);
              widget.username = newValue;
            });
            
          }

          if (field == "bio"){
            setState(() {
              widget.bio = newValue;
            });
          }

          if (field == "pronouns"){
            setState(() {
              widget.pro = newValue;
            });
          }

          await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).update({
            field: newValue,
          });

          //pop dialog
          Navigator.pop(context);

        }, child: const Text("Save")),

      ],
    ),);
  }

  bool buttonOn = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _pronounsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.username;
    _bioController.text = widget.bio;
    _pronounsController.text = widget.pro;
  }


  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold( key: const Key('profile-page'),
    resizeToAvoidBottomInset: true,
    backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Row(children: [
            const Icon(Icons.edit),
            const SizedBox(width: 10,),
            Center(child: Text(widget.email)),
        ],),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50,),
                    const Center(child: Icon(Icons.person, size: 72,),) ,
                    const SizedBox(height: 50,),
                    const Text("My Details", textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    Column(
                      children: [
                        CustomTextBox(text: widget.username, sectionName: "Username", onPressed: () => editField('username'),),
                        const SizedBox(height: 10,),
                        CustomTextBox(text: widget.pro, sectionName: "Pronouns", onPressed: () => editField('pronouns'),),
                        const SizedBox(height: 10,),
                        CustomTextBox(text: widget.bio, sectionName: "Bio", onPressed: () => editField('bio'),),
                        const SizedBox(height: 10,),
                      ],
                    )
                    
                      
                  ],
                  ),
              ),
            ),
        ),
    );
  }
}