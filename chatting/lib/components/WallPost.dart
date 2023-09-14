import 'package:chatting/components/Comment.dart';
import 'package:chatting/components/CommentButton.dart';
import 'package:chatting/components/DeleteButton.dart';
import 'package:chatting/components/likeButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String userEmail;
  final String time;
  final String postID;
  final List<String> likes;
  const WallPost({super.key, required this.message, required this.time, required this.user, required this.userEmail, required this.postID, required this.likes});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  
  //get user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  int commentCount = 0;

  //text controller for comment
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //getCommentCount();
    isLiked = widget.likes.contains(currentUser.email);
  }

  /*void getCommentCount() async {
    await FirebaseFirestore.instance.collection('User Posts').get().then((value) => commentCount = value.docs.length).catchError((error) => print("Failed to get comment count: $error"));

  }*/

  void toggleLike(){
    setState(() {
      isLiked = !isLiked;
    });

    // Access Doc in firebase
    DocumentReference postRef = FirebaseFirestore.instance.collection('User Posts').doc(widget.postID);

    if(isLiked){
      // if post is liked, add user to likes list.
      postRef.update({
        'Likes' : FieldValue.arrayUnion([currentUser.email])
      });

    }
    else{
      // if post is unliked, remove user from likes list.
      postRef.update({
        'Likes' : FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  //add a comment method
  void AddComment(String commentText){
    //Write the comment to firestore under comment collection
    FirebaseFirestore.instance.collection('User Posts').doc(widget.postID).collection('Comments').add({
      'Comment' : commentText,
      'CommentByEmail' : currentUser.email,
      'CommentByUsername' : currentUser.displayName,
      'CommentTime' : DateTime.now().toString()
    });
  }

  //show dialog box for adding a comment
  void ShowCommentDialog(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("Add a comment"),
      content: TextField(
        controller: _commentController,
        decoration: const InputDecoration(hintText: "Write a comment.."),
      ),
      actions: [
        //cancel button
        TextButton(onPressed: () {
          //pop box
          Navigator.pop(context);

          //clear controller
          _commentController.clear();

        }, child: const Text('Cancel')),
        
        //post button
        TextButton(onPressed: () {
          //add the comment
          AddComment(_commentController.text);

          //clear controller
          _commentController.clear();

          //pop box
          Navigator.pop(context);
        }, child: const Text('Post')),
      ],
    ),);
  }

  String ConvertTime(String TimeStamp){
    var TimeDiff = DateTime.now().difference(DateTime.parse(TimeStamp)).abs();
    if(TimeDiff.inSeconds < 60){
      return "${TimeDiff.inSeconds} seconds ago";
    }
    else if(TimeDiff.inMinutes < 60){
      return "${TimeDiff.inMinutes} minutes ago";
    }
    else if(TimeDiff.inHours < 24){
      return "${TimeDiff.inHours} hours ago";
    } 
    else if(TimeDiff.inDays < 7){
      return "${TimeDiff.inDays} days ago";
    }
    else if(TimeDiff.inDays < 30){
      return "${TimeDiff.inDays ~/ 7} weeks ago";
    }
    else if(TimeDiff.inDays < 365){
      return "${TimeDiff.inDays ~/ 30} months ago";
    }
    else{
      return "${TimeDiff.inDays ~/ 365} years ago";
    }
  }

  // ignore: non_constant_identifier_names
  String ConvertFromString(){
    var TimeDiff = DateTime.now().difference(DateTime.parse(widget.time)).abs();
    if(TimeDiff.inSeconds < 60){
      return "${TimeDiff.inSeconds} seconds ago";
    }
    else if(TimeDiff.inMinutes < 60){
      return "${TimeDiff.inMinutes} minutes ago";
    }
    else if(TimeDiff.inHours < 24){
      return "${TimeDiff.inHours} hours ago";
    } 
    else if(TimeDiff.inDays < 7){
      return "${TimeDiff.inDays} days ago";
    }
    else if(TimeDiff.inDays < 30){
      return "${TimeDiff.inDays ~/ 7} weeks ago";
    }
    else if(TimeDiff.inDays < 365){
      return "${TimeDiff.inDays ~/ 30} months ago";
    }
    else{
      return "${TimeDiff.inDays ~/ 365} years ago";
    }
  }

  void deletePost(){
    //show a dialog to confirm delete
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("Delete Post"),
      content: const Text("Are you sure you want to delete this post?"),
      actions: [
        //Cancel Button
        TextButton(onPressed: () {
          //pop box
          Navigator.pop(context);
          return;
        }, child: const Text("Cancel")),

        //Confirm Delete Button
        TextButton(onPressed: () async {
          //delete the comments
          final commentDocs = await FirebaseFirestore.instance.collection('User Posts').doc(widget.postID).collection('Comments').get();

          for(var doc in commentDocs.docs){
            await FirebaseFirestore.instance.collection("User Posts").doc(widget.postID).collection('Comments').doc(doc.id).delete();
          }

          //delete post from firebase
          FirebaseFirestore.instance.collection('User Posts').doc(widget.postID).delete().then((value) => print("Post Deleted")).catchError((error) => print("Failed to delete post: $error"));

          Navigator.pop(context);
        }, child: const Text("Delete")),
        
      ],
    ));

    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //post
          const SizedBox(width: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //group of text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.user, style: const TextStyle(color: Colors.grey),),
                  Text(ConvertFromString(), style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Text(widget.message, style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color),)
                ],
              ),

              //delete button
              if(widget.userEmail == currentUser.email)
                DeleteButton(onDelete: deletePost),
            ],
          ),
          const SizedBox(height: 20,),
          //Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Like
              Column(
                children: [
                  //like button
                  LikeButton(isLiked: isLiked, onLike: toggleLike),

                  const SizedBox(height: 5),

                  //like counter
                  Text("${widget.likes.length}", style: TextStyle(color: Theme.of(context).appBarTheme.iconTheme!.color!),),
                ],
            ),
              //comment
              const SizedBox(width: 20,),
              Column(
              children: [
                //comment button
                CommentButton(onTap: ShowCommentDialog),

                const SizedBox(height: 5),

                //comment counter
                Text("${commentCount}", style: TextStyle(color: Theme.of(context).appBarTheme.iconTheme!.color!),),

              ],
         ),
            ],
          ),

          const SizedBox(height: 10,),

          //Comments
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('User Posts').doc(widget.postID).collection('Comments').orderBy('CommentTime', descending: true).snapshots(),
            builder: (context, snapshot) {
            //Show loading circle if data is not loaded
            if(!snapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: snapshot.data!.docs.map((docs){
                //get the comment from firebase
                final commentData = docs.data() as Map<String, dynamic>;
                //show comment on UI
                return Comment(
                  comment: commentData['Comment'],
                  user: commentData['CommentByUsername'], 
                  time: ConvertTime(commentData['CommentTime']),
                );
              }).toList(),
            );
          })
        ],
      ),
    );
  }
}