import 'package:befit_ai_app/view/Screens/home_screen.dart';
import 'package:befit_ai_app/view/auth/sign_up.dart';
import 'package:befit_ai_app/view/widgets/textfield.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth= FirebaseAuth.instance;

final TextEditingController emailController=TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading=false;

  Future<void> _loginWithEamil() async{
    setState(() {
      _isLoading=true;
    });

    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: _passwordController.text.trim()
      );
      print("USer logged in:${userCredential.user?.email}");

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> HomePage())
      );
    }catch(err){
print('FAiled: '+err.toString());
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Login FAiled'))
);
    }
    finally{
      setState(() {
        _isLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text('Hey! Welcome back..\nLogin',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
            const SizedBox(height: 30,),
            CustomTextField(

                hint: 'Enter Your Email',
                icon: const Icon(Icons.email),
                label: 'Email',

                controller: emailController
            ),
            const SizedBox(height: 20,),
            CustomTextField(
                hint: 'Your Password',
                label: 'Password',
                controller: _passwordController,
                icon:const Icon(Icons.password),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                _loginWithEamil();
               },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
               margin: const EdgeInsets.symmetric(horizontal: 25),
                padding:const EdgeInsets.symmetric(vertical: 12),
                child:const Text('Login',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t Have Account?'),
                TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUp()));
                  print('clicked');}, child:const Text('Register'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
