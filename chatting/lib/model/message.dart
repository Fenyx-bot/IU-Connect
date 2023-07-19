import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderID;
  final String sendrUsername;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderID,
    required this.sendrUsername,
    required this.receiverID,
    required this.message,
    required this.timestamp
  });

  //convert to map
  Map<String, dynamic> toMap() {
    return {
      'senderId' : senderID,
      'senderEmail' : sendrUsername,
      'receiverId' : receiverID,
      'message' : message,
      'timestamp' : timestamp,
    };
  }
}