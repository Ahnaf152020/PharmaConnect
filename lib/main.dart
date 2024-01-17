import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/chatroom.dart';
import 'package:pharmaconnectbyturjo/chatsearchpage.dart';
import 'package:pharmaconnectbyturjo/pages/ForgotPassword.dart';
import 'package:pharmaconnectbyturjo/pages/LoginPage.dart';
import 'package:pharmaconnectbyturjo/pages/Update_Profile.dart';
//import 'package:pharmaconnectbyturjo/pages/UserPage.dart';
import 'package:pharmaconnectbyturjo/pages/startPage.dart';
import 'package:pharmaconnectbyturjo/register.dart';
import 'package:pharmaconnectbyturjo/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pharmaconnectbyturjo/widget.dart';
import 'package:pharmaconnectbyturjo/pages/ForgotPassword.dart';
import 'package:pharmaconnectbyturjo/Contains/SurgicalProduct.dart';
import 'package:pharmaconnectbyturjo/Contains/PersonalCare.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid?
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyC_tlswOmwEsCAvNTU7oT-fasgMAEroyFE",
      appId: "1:1126007332:android:fae77dd398b14a2b958eb1",
      messagingSenderId: "1126007332",
      projectId: "pharmaconnect-caa87",
      storageBucket: "pharmaconnect-caa87.appspot.com"),)
  : await Firebase.initializeApp();
  bool isLoggedIn= false;
  final user = FirebaseAuth.instance.currentUser;
  if(user!=null) isLoggedIn = true;

  runApp(
      MaterialApp(

      debugShowCheckedModeBanner: false,

      home: isLoggedIn ? const HomePage() : const LoginPage(),
    initialRoute: 'StartPage',
    routes: {
      'Startpage': (context) => StartPage(),
      'LoginPage': (context) => LoginPage(),
      'register': (context) => Myregister(),
      'forgotpassword': (context) => forgotPasswordScreen(),
      'widget': (context) => Mywidget(),
      'HomePage': (context) => HomePage(),
      'chatsearchpage': (context) => chatpage(),


      'Update_Profile': (context) =>AccountScreen(),
      'PersonalCare': (context) =>PersonalProduct(),
      'SurgicalProduct': (context) =>SurgicalProduct()

    },

));
}
/*void initState() {
  // TODO: implement initState
  super.initState();
}*/