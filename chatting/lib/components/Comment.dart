import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String comment;
  final String user;
  final String time;
  const Comment({
    super.key, 
    required this.comment,
    required this.user,
    required this.time
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        //user, time
        Row(
          children: [
            Text(user, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),),
            const SizedBox(width: 10,),
            Text(time, style: TextStyle(color: Colors.grey[600]),),
          ],
        ),

        const SizedBox(height: 5,),

        //comment
        Text(comment, style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color,),),
      ]),
    );
  }
}