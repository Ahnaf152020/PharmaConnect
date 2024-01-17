import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  late User _user;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _user = _auth.currentUser!;
    DocumentSnapshot userSnapshot = await users.doc(_user.uid).get();

    setState(() {
      _usernameController.text = userSnapshot['user name'];
      _emailController.text = userSnapshot['e-mail'];
      _addressController.text = userSnapshot['address'];
      _profileImageUrl = userSnapshot['profileImageUrl'];
    });
  }

  Future<void> _updateUserProfile() async {
    try {
      await users.doc(_user.uid).update({
        'user name': _usernameController.text,
        'e-mail': _emailController.text,
        'address': _addressController.text,
        'profileImageUrl': _profileImageUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User profile updated successfully!'),
        ),
      );
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  Future<void> _uploadImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      String fileName = 'profile_${_user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageReference = _storage.ref().child(fileName);

      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _profileImageUrl = downloadUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _uploadImage,
              child: _profileImageUrl != null
                  ? CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_profileImageUrl!),
              )
                  : CircleAvatar(
                radius: 50,
                child: Icon(Icons.camera_alt),
              ),
            ),
            SizedBox(height: 10),
            Container(child: Text('${_usernameController.text}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                height: 1.5, // Adjust the height as needed
              ),)),
            SizedBox(height: 20),

            Text('Username:'),
            TextField(
              controller: _usernameController,
              decoration: const  InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Email:'),
            TextField(
              controller: _emailController,
              decoration: const  InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Address:'),
            TextField(
              controller: _addressController,
              decoration: const  InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserProfile,
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserProfileScreen(),
  ));
}
