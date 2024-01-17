import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pharmaconnectbyturjo/pages/edit_item.dart';
import 'package:pharmaconnectbyturjo/Contains/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmaconnectbyturjo/pages/UserProfile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pharmaconnectbyturjo/Contains/Database.dart';



class EditAccountScreen extends StatefulWidget {

  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {

  late User _user;
  late UserProfile _userProfile;


  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _loadUserProfile();
  }






  Uint8List? _image;
  final TextEditingController nameController =TextEditingController();
  final TextEditingController phoneController =TextEditingController();
  final TextEditingController ageController =TextEditingController();
  final TextEditingController addressController =TextEditingController();



  void selectImage() async{
    Uint8List img =await pickImage(ImageSource.gallery);
    setState(()
    {
      _image =img;
    }
    );
  }




  void saveProfile(){
    // _updateProfile();
    _loadUserProfile();


  }
  String gender = "man";
  Future<void> _loadUserProfile() async {
    DocumentSnapshot userSnapshot =
    await FirebaseFirestore.instance.collection('UserProfile').doc(_user.uid).get();

    if (userSnapshot.exists) {
      setState(() {
        _userProfile = UserProfile(
          uid: _user.uid,
          displayName: userSnapshot['displayName'],
          photoURL: userSnapshot['photoURL'],
        );
      });
    }
  }
  Future<void> _updateProfile(String displayName, String photoURL) async {
    await _user.updateDisplayName(displayName);
    await _user.updatePhotoURL(photoURL);

    await FirebaseFirestore.instance.collection('UserProfile').doc(_user.uid).set({
      'displayName': displayName,
      'photoURL': photoURL,
    });
  }
  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      String imageName = 'user_${_user.uid}';
      Reference storageRef = FirebaseStorage.instance.ref().child('ProfileImages/$imageName.jpg');

      /*await storageRef.putFile(_image!);
      String downloadURL = await storageRef.getDownloadURL();*/

      //await _updateProfile(_userProfile.displayName, downloadURL);
      _loadUserProfile();
    } catch (e) {
      print('Error uploading image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Ionicons.chevron_back_outline),
          ),
          leadingWidth: 80,
          actions: [

          ],
        ),

        body: Center(
            child : Container(

              padding : EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24,),

                  Stack(
                    children: [
                      _image != null ?
                      CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage( _image!),
                      ) :
                      const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage('https://w7.pngwing.com/pngs/481/915/png-transparent-computer-icons-user-avatar-woman-avatar-computer-business-conversation.png'),

                        /*_userProfile.photoURL.isNotEmpty
                            ? NetworkImage(_userProfile.photoURL)
                            : null,*/

                      ),
                      Positioned(
                        bottom:  -10,
                        left: 80,
                        child:
                        IconButton(
                          onPressed: selectImage,
                          icon: Icon(Icons.add_a_photo),
                        ),

                      )
                    ],
                  ),
                  const SizedBox(height: 24,),
                  TextField(
                    controller: nameController,
                    decoration:  const InputDecoration(
                      hintText: 'Enter Name',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),

                    ),
                  ),
                  const SizedBox(height: 24,),
                  TextField(
                    controller: phoneController,
                    decoration: const  InputDecoration(
                      hintText: 'Enter Phone number',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),

                    ),
                  ),
                  const SizedBox(height: 24,),
                  TextField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Age',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),

                    ),
                  ),
                  const SizedBox(height: 24,),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Adress',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),

                    ),
                  ),
                  const SizedBox(
                    height: 24,

                  ),
                  ElevatedButton(
                    onPressed: saveProfile,
                    child: const  Text('Save Profile'),

                  )



                ],
              ),
            )

        )
    );

  }
}
