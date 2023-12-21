import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
  FirebaseAuth _auth =FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String username,String email,String password) async{

    try{
      UserCredential credential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(a){
      print("some error occured in signup ");
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential credential=await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(a){
      print("some error occured in signin");
    }

    return null;
  }
}