import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
class FirebaseAuthService{
  final FirebaseAuth _auth =FirebaseAuth.instance;


  Future<User?> signUpWithEmailAndPassword(String username,String email,String password) async{

    try{
      UserCredential credential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }  on FirebaseAuthException catch(e){

        if(e.code == 'email-already-in-use'){
        print('The e-mail address is already in use');

        }else{
          print('An error occurred :${e.code}');
        }
      }


    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential credential=await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch(e){

      if(e.code == 'user-not-found' || e.code =='wrong password'){
        showToast(message: "Invalid e-mail or password");
      }else{
        showToast(message: 'An error occured: ${e.code}');
      }

    }

    return null;
  }
   void forgetPassword(String email) {
     _auth.sendPasswordResetEmail(email: email).then((value) {
       var Get;
       Get.back();
       showToast(message: 'Email Sent, We have sent password reset email');
     }).catchError((e) {
       showToast(message: "Error in sending password reset email is $e");
     });
   }
}

