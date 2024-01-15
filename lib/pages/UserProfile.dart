
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';




class UserProfile {
  final String uid;
  final String displayName;
  final String photoURL;

  UserProfile({
    required this.uid,
    required this.displayName,
    required this.photoURL,
  });
}
