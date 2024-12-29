import 'package:befit_ai_app/controller/auth_controller.dart';
import 'package:befit_ai_app/view/Screens/home_screen.dart';
import 'package:befit_ai_app/view/auth/login_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}
AuthController _authController =AuthController();
TextEditingController emailController=TextEditingController();
TextEditingController _passwordController=TextEditingController();
TextEditingController _confirmPasswordController=TextEditingController();
TextEditingController username= TextEditingController();

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hey! Welcome back..\nLogin',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),),
            const SizedBox(height:30),
            CustomTextField(
                hint: 'Enter Your Neme',
                label: 'Username',
                controller: username,
                icon: const Icon(Icons.person_3)),
            const SizedBox(height: 20,),
            CustomTextField(
                hint: 'Enter Your Email',
                icon: const Icon(Icons.email),
                label: 'Email',

                controller: emailController,
            ),
            const SizedBox(height: 20,),
            CustomTextField(
              hint: 'Your Password',
              label: 'Password',
              controller: _passwordController,
              icon: const Icon(Icons.password),
            ),
            const SizedBox(height: 20,),
            CustomTextField(
              hint: 'Re-Enter Your Password',
              label: 'Confirm Password',
              controller: _confirmPasswordController,
              icon:const Icon(Icons.password),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: () {

if(_passwordController.text==_confirmPasswordController.text){
             _authController.signUp(
                    emailController.text.trim(),
                    _passwordController.text.trim(),
                    username.text.trim()
                );
             Navigator.of(context).pushReplacement(
                 MaterialPageRoute(builder: (context)=> HomePage())
             );
               }else{
               throw Exception('Password Do not Match');
            }},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding:const EdgeInsets.symmetric(vertical: 12),
                child:const Text('Sign-In',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Text('Already have account?'),
                TextButton(onPressed: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context)=>LoginScreen()),
                  );
                }, child:const Text('Login')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
