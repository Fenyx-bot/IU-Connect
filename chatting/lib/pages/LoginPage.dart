// ignore: file_names
import "package:chatting/components/CustomButton.dart";
import "package:chatting/components/CustomTextField.dart";
import "package:chatting/services/auth/auth_service.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign in function
  void signIn() async {
    //Get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      await authService.signInWithEmailandPassword(emailController.text, passwordController.text);
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const SizedBox(height: 50,),

              //logo
              Icon(Icons.message, size: 100,color: Colors.grey[800],),

              const SizedBox(height: 50,),
                  
              // welcome back text
              const Text("Welcome Back, You've been missed!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

              const SizedBox(height: 25,),
                  
              //email textfield
              CustomTextField(controller: emailController, hintText: 'Email', obscureText: false),

              const SizedBox(height: 10,),
                  
              //password textfield
              CustomTextField(controller: passwordController, hintText: 'Password', obscureText: true),

              const SizedBox(height: 25,),
                  
              //sign in button
              CustomButton(onTap: signIn, text: 'Sign In'), //TODO: add onTap function

              const SizedBox(height: 50,),
                  
              //become a member button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text('Not a member?'),
                const SizedBox(width: 4,),
                GestureDetector(onTap: widget.onTap ,child: const Text('Sign Up Now!', style: TextStyle(fontWeight: FontWeight.bold),))

              ],)

            ]),
          ),
        ),
      ),
    );
  }
}
