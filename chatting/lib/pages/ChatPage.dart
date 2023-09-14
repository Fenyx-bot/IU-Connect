import 'package:chatting/components/ChatBubble.dart';
import 'package:chatting/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUsername;
  final String receiverUserID;
  const ChatPage({super.key, required this.receiverUsername, required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  final ScrollController _scrollController = ScrollController();
  final bool InitialScroll = true;

  void sendMessage() async {
    if(_messageController.text.isNotEmpty){ // only send a message if the message controller is not empty
      String message = _messageController.text;
      _messageController.clear(); // clear the message controller after sending the message
      await _chatService.sendMessage(widget.receiverUserID, message);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(widget.receiverUsername),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          //messages
          Expanded(child: _buildMessagesList()), 
          
          const SizedBox(height: 15,),

          //user input
          _buildMessagesInput(),

          const SizedBox(height: 15,),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessagesList(){
    return StreamBuilder(
      stream: _chatService.getMessages(widget.receiverUserID, _auth.currentUser!.uid),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Text('Something went wrong, Error: ${snapshot.error}');
        }

        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading..');
        }

        if(snapshot.hasData){
          if(InitialScroll){
            WidgetsBinding.instance.addPostFrameCallback((_) => _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
          }

        }

        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
          );
      },
    );
  }


  //build message item 
  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align the messages to the right if the sender is the current user otherwise align to the left
    var alignment;
    
    if (data['senderId'] == _auth.currentUser!.uid){
      alignment = Alignment.centerRight;
    }
    else{
      alignment = Alignment.centerLeft;
    }

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: data['senderId'] == _auth.currentUser!.uid ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId'] == _auth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 5),
            ChatBubble(message: data['message']),
          ],
        ),
      ),  
    );
  }


  //build message input
  Widget _buildMessagesInput(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          //textfield
          Expanded(child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
            suffixIcon: IconButton(icon: Icon(Icons.arrow_circle_right, color: Theme.of(context).appBarTheme.iconTheme!.color,), onPressed: sendMessage),
            hintText: 'Send a message',
            enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(15.0)
            ),
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, ),
            borderRadius: const BorderRadius.all(Radius.circular(15.0))
            ),
            fillColor: Theme.of(context).colorScheme.primary,
            filled: true,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),),
    )),
        ],
      ),
    );
  }
}