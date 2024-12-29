import 'package:befit_ai_app/view/Screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:befit_ai_app/models/user_model.dart';
import 'package:befit_ai_app/controller/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthController{
  final FirebaseAuth _auth= FirebaseAuth.instance;
  final UserServices _firebaseFirestore = UserServices();
  Future<UserModel?> signUp(String email,String password,String username) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      await _firebaseFirestore.saveUser(userCredential.user!.uid, username);

      return UserModel(uid: userCredential.user!.uid, username: username);

    }catch(err){
      throw Exception("Error : ${err}");
    }
  }


  Future<UserModel?> login(String email,String password)async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      UserModel? details= await _firebaseFirestore.getUser(userCredential.user!.uid);
    print(details);
      return details;
  }catch(e){
      throw Exception('Error:${e}');
    }
}
  Future<String?> fetchUsername() async {
    User? user = getCurrentUser();
    if (user != null) {
      UserModel? userModel = await UserServices().getUser(user.uid);
      return userModel?.username;
    }
    return null;
  }
User? getCurrentUser(){
    return _auth.currentUser;
}
Future<void> signout()async{
    await _auth.signOut();
}
}