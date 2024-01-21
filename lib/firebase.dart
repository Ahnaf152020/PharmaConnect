import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
class FirebaseAuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(String username,String email,String password) async{

    try{
      UserCredential credential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      credential.user!.updateDisplayName(username);

      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "user name": username,
        "e-mail": email,
        "status": "Unavalible",
        "uid": _auth.currentUser!.uid,
      });
      return credential.user;
    }  on FirebaseAuthException catch(e){

        if(e.code == 'email-already-in-use'){
        showToast(message: 'The e-mail address is already in use');

        }else {
          showToast(message: 'An error occurred :${e.code}');
        }

      }


    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential credential=await _auth.signInWithEmailAndPassword(email: email, password: password);

      _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) => credential.user!.updateDisplayName(value['user name']));

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
//signout method
  Future<void> signUserout() async{
    await FirebaseAuth.instance.signOut();
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

