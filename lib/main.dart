import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/pages/ForgotPassword.dart';
import 'package:pharmaconnectbyturjo/pages/LoginPage.dart';
import 'package:pharmaconnectbyturjo/pages/Update_Profile.dart';
import 'package:pharmaconnectbyturjo/pages/edit_screen.dart';
import 'package:pharmaconnectbyturjo/pages/forward_button.dart';
import 'package:pharmaconnectbyturjo/pages/setting_switch.dart';
import 'package:pharmaconnectbyturjo/pages/startPage.dart';
import 'package:pharmaconnectbyturjo/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pharmaconnectbyturjo/widget.dart';
import 'package:pharmaconnectbyturjo/pages/ForgotPassword.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid?
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyC_tlswOmwEsCAvNTU7oT-fasgMAEroyFE",
      appId: "1:1126007332:android:fae77dd398b14a2b958eb1",
      messagingSenderId: "1126007332",
      projectId: "pharmaconnect-caa87"),)
  : await Firebase.initializeApp();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home:

      StartPage(),
    initialRoute: 'StartPage',
    routes: {
      'Startpage': (context) => StartPage(),
      'LoginPage': (context) => LoginPage(),
      'register': (context) => Myregister(),
     'forgotpassword': (context) => forgotPasswordScreen(),
      'Update_Profile': (context) => AccountScreen(),
      'widget': (context) => Mywidget(),
      'edit_screen': (context) =>   EditAccountScreen(),

    },

));
}