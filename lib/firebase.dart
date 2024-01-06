

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  /*var isProfileInformationLoading = false.obs;

  Future<String> uploadImageToFirebaseStorage(File image) async {
    String imageUrl = '';
    String fileName = Path.basename(image.path);

    var reference =
    FirebaseStorage.instance.ref().child('profileImages/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      imageUrl = value;
    }).catchError((e) {
      showToast(message: "Error happen $e");
    });

    return imageUrl;
  }




  uploadProfileData(String imageUrl, String firstName, String lastName,
      String mobileNumber, String dob, String gender) {

    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'image': imageUrl,
      'first': firstName,
      'last': lastName,
      'dob': dob,
      'gender': gender
    }).then((value) {
      isProfileInformationLoading(false);
      //Get.offAll(()=> BottomBarView());

    });

  }*/
}

