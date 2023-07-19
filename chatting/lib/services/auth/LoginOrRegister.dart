import 'package:chatting/pages/LoginPage.dart';
import 'package:chatting/pages/RegisterPage.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //Initially show the login page
  bool ShowLoginPage = true;

  //toggle between login and register
  void togglePage() {
    setState(() {
      ShowLoginPage = !ShowLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(ShowLoginPage){
      return LoginPage(onTap: togglePage);
    }else{
      return RegisterPage(onTap: togglePage);
    }
  }
}