// ignore: file_names
import "package:chatting/components/CustomButton.dart";
import "package:chatting/components/CustomTextField.dart";
import "package:chatting/services/auth/auth_service.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  //sign up function
  void signUp() async {
    if(emailController.text.isEmpty || passwordController.text.isEmpty || repeatPasswordController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill in all fields!")));
      return;
    }

    if(passwordController.text != repeatPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords do not match!")));
      return;
    }

    /*if(emailController.text.contains("@IU-study.org") == false){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter a valid email!")));
      return;
    }*/

    //show loading circle
    showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.white,),), barrierDismissible: false,);
    
    //Get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      await authService.signUpWithEmailandPassword(emailController.text, passwordController.text);
      
      Navigator.pop(context);
      
    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        reverse: true,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const SizedBox(height: 50,),
      
                //logo
                Icon(Icons.message, size: 100,color: Theme.of(context).appBarTheme.iconTheme!.color,),
      
                const SizedBox(height: 50,),
                    
                // welcome back text
                const Text("Let's get you started!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      
                const SizedBox(height: 25,),

                //email textfield
                CustomTextField(controller: emailController, hintText: 'Email', obscureText: false),
      
                const SizedBox(height: 10,),
                    
                //password textfield
                CustomTextField(controller: passwordController, hintText: 'Password', obscureText: true),

                const SizedBox(height: 10,),
                    
                //password textfield
                CustomTextField(controller: repeatPasswordController, hintText: 'Repeat Password', obscureText: true),
      
                const SizedBox(height: 25,),
                    
                //sign in button
                CustomButton(onTap: signUp, text: 'Sign Up'), //TODO: add onTap function
      
                const SizedBox(height: 50,),
                    
                //become a member button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('Already a member?', style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle!.color),),
                  const SizedBox(width: 4,),
                  GestureDetector(onTap: widget.onTap ,child: Text('Login Now!', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).appBarTheme.titleTextStyle!.color),))
      
                ],)
      
              ]),
            ),
          ),
        ),
      ),
    );
  }
}