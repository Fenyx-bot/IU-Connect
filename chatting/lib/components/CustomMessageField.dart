import "package:flutter/material.dart";

// ignore: must_be_immutable
class CustomMessageField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final void Function()? onSendPressed;
  CustomMessageField({super.key, required this.controller, required this.hintText, required this.obscureText, required this.onSendPressed});

  Icon sendIcon = Icon(Icons.menu, color:Colors.grey[800]);

  setstate(){
    if(controller.text.isNotEmpty){
      sendIcon = Icon(Icons.arrow_circle_right, color:Colors.grey[800]);
    }else{
      sendIcon = Icon(Icons.menu, color:Colors.grey[800]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(icon: sendIcon, onPressed: onSendPressed),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200)
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
        ),
        fillColor: Colors.grey[100],
        filled: true,
        hintStyle: const TextStyle(color: Colors.black45),

      ),
    );
  }
}