import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( key: const Key('post-page'),
    resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(children: [
            const Expanded(child: SizedBox(width: 10,)),
            TextButton(onPressed: () {}, child: Row(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white, width: 1.5)
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("POST", style: TextStyle(color: Colors.white,),),
                ),
              )

            ],),),
        ],),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Center(
            child: Column(
              children: [
                TextField(
                  maxLines: 20,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade200)
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.black45),
                    hintText: "What's on your mind?",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    )
                  ),
                ),
              ]
            ),
          )
        )
    );
  }
}