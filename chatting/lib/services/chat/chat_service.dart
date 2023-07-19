import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/message.dart';

class ChatService extends ChangeNotifier{
  //get instance of auth and firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //SEND MESSAGE
  Future<void> sendMessage(String receiverID, String message) async {
    //get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUsername = _auth.currentUser!.displayName!;
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
      senderID: currentUserId,
      sendrUsername: currentUsername,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
      );


    //construct chat room id from current user id and receiver id (sorted to insyre uniqueness)
    List<String> ids = [currentUserId, receiverID];
    ids.sort();
    String chatRoomID = ids.join('_'); //combine the IDS with an underscore
    



    //add message to the database
    await _firestore.collection('chatrooms').doc(chatRoomID).collection('messages').add(newMessage.toMap());

  }

  //RECEIVE MESSAGE
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId){
    //construct chat room id from current user id and receiver id (sorted to insyre uniqueness)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomID = ids.join('_'); //combine the IDS with an underscore

    return _firestore.collection('chatrooms').doc(chatRoomID).collection('messages').orderBy('timestamp', descending: false).snapshots();
  }


}