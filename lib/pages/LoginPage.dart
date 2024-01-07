import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/pages/ForgotPassword.dart';

import 'package:google_sign_in/google_sign_in.dart';
import "package:iconsax/iconsax.dart";
import 'package:pharmaconnectbyturjo/toast.dart';
import 'package:pharmaconnectbyturjo/widget.dart';

import '../firebase.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController forgetEmailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  var _isObscured;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  int activeIndex = 0;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        activeIndex++;

        if (activeIndex == 5) activeIndex = 0;
      });
    });
    _isObscured = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                height: 300,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: activeIndex == 0 ? 1 : 0,
                      duration: Duration(
                        seconds: 3,
                      ),
                      curve: Curves.linear,
                      child: Image.asset(
                        "assets/images/PharmaConnectlogo.jpg",
                        height: 400,
                        width: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: activeIndex == 1 ? 1 : 0,
                      duration: Duration(
                        seconds: 2,
                      ),
                      curve: Curves.linear,
                      child: Image.asset(
                        "assets/images/image1.png",
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: activeIndex == 2 ? 1 : 0,
                      duration: Duration(seconds: 2),
                      curve: Curves.linear,
                      child: Image.asset(
                        "assets/images/image2.png",
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: activeIndex == 3 ? 1 : 0,
                      duration: Duration(seconds: 2),
                      curve: Curves.linear,
                      child: Image.asset(
                        "assets/images/image3.png",
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: activeIndex == 4 ? 1 : 0,
                      duration: Duration(seconds: 2),
                      curve: Curves.linear,
                      child: Image.asset(
                        "assets/images/image4.png",
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: activeIndex == 5 ? 1 : 0,
                      duration: Duration(seconds: 2),
                      curve: Curves.linear,
                      child: Image.asset(
                        "assets/images/image5.png",
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _emailController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Email',
                  hintText: 'Username or e-mail',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  prefixIcon: Icon(
                    Iconsax.user,
                    color: Colors.black,
                    size: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade200, width: 3),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                focusNode: passwordFocusNode,
                controller: _passwordController,
                cursorColor: Colors.black,
                obscureText: _isObscured,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    padding: const EdgeInsetsDirectional.only(end: 12.0),
                    icon: _isObscured
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Password',
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Iconsax.key,
                    color: Colors.blue,
                    size: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade200, width: 3),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => forgotPasswordScreen()));
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: _signIn,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.lightBlueAccent,
                      ),
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: _isSigning
                          ? CircularProgressIndicator(
                              color: Colors.green,
                            )
                          : Text(
                              "Login",
                              style: TextStyle(color: Colors.black),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Or continue with",
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _signInWithGoogle();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                          image: const DecorationImage(
                            image: AssetImage("assets/images/google.png"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.grey[200]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      if (user != null) {
        showToast(message: "succesfully done signin");
        Navigator.pushNamed(context, 'HomePage');
      } else {
        showToast(message: "error occured in signin");
      }
    } else {
      showToast(message: "Please enter the field");
    }
  }

  _signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Navigator.pushNamed(context, "HomePage");
      }
    } catch (e) {
      showToast(message: "some error occured $e");
    }
  }
}
