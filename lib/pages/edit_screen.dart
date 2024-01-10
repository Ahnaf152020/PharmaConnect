import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pharmaconnectbyturjo/pages/edit_item.dart';
import 'package:pharmaconnectbyturjo/Contains/utils.dart';


class EditAccountScreen extends StatefulWidget {

  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {



  Uint8List ? _image;
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

  }
  String gender = "man";

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
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  fixedSize: Size(60, 50),
                  elevation: 3,
                ),
                icon: Icon(Ionicons.checkmark, color: Colors.white),
              ),
            ),
          ],
        ),
        /*body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Account",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Photo",
                widget: Column(
                  children: [
                    Image.asset(
                      "assets/avatar.png",
                      height: 100,
                      width: 100,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.lightBlueAccent,
                      ),
                      child: const Text("Upload Image"),
                    )
                  ],
                ),
              ),
              const EditItem(
                title: "Name",
                widget: TextField(),
              ),
              const SizedBox(height: 40),
              EditItem(
                title: "Gender",
                widget: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          gender = "man";
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: gender == "man"
                            ? Colors.deepPurple
                            : Colors.grey.shade200,
                        fixedSize: const Size(50, 50),
                      ),
                      icon: Icon(
                        Ionicons.male,
                        color: gender == "man" ? Colors.white : Colors.black,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          gender = "woman";
                        });
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: gender == "woman"
                            ? Colors.deepPurple
                            : Colors.grey.shade200,
                        fixedSize: const Size(50, 50),
                      ),
                      icon: Icon(
                        Ionicons.female,
                        color: gender == "woman" ? Colors.white : Colors.black,
                        size: 18,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const EditItem(
                widget: TextField(),
                title: "Age",
              ),
              const SizedBox(height: 40),
              const EditItem(
                widget: TextField(),
                title: "Email",
              ),
            ],
          ),
        ),
      ),
    );*/
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
                    child: const  Text('Save Profile'),)



                ],
              ),
            )

        )
    );

  }
}