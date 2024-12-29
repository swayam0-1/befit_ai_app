import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:befit_ai_app/models/user_model.dart';

class UserServices{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> saveUser(String uid,String username) async{
    await _firebaseFirestore.collection('users').doc(uid).set({
      'username':username,
    });
  }

  Future<UserModel?> getUser(String uid) async{
    DocumentSnapshot snapshot = await _firebaseFirestore.collection('users').doc(uid).get();
    if(snapshot.exists){
      return UserModel(uid: uid, username: snapshot['username']);
    }
    return null;
  }
}