import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/toast.dart';
import 'firebase.dart';

class Myregister extends StatefulWidget {
  const Myregister({super.key});

  @override
  State<Myregister> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<Myregister> {

  static const lightBlue = Color(0xff1E2E3D);
  static const blue = Color(0xff152534);
  static const darkBlue = Color(0xff0C1C2E);
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isSigninup = false;
  final emailFocusNode  = FocusNode();
  final passwordFocusNode  = FocusNode();



  var _isObscured;

  void initState(){

    _isObscured =true;

  }

  @override
  void dispose(){
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightBlue,
                    blue,
                    darkBlue,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Create your account',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _usernameController,

                    decoration: InputDecoration(
                        fillColor: Colors.black,
                        labelText: 'Name',labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        hintText: 'Enter Your Name'),

                    //keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        fillColor: Colors.black,
                        labelText: 'Email',labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        hintText: 'Enter Your Email'),
                    // keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  TextField(
                    obscureText: _isObscured,
                    focusNode: passwordFocusNode,
                    //keyboardType: TextInputType.emailAddress,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        padding: const EdgeInsetsDirectional.only( end :12.0),
                        icon: _isObscured ? const Icon (Icons.visibility): const Icon(Icons.visibility_off),
                        onPressed: (){
                          setState(() {
                            _isObscured   = !_isObscured;
                          });
                        },),
                      fillColor: Colors.black,
                      //icon: new Icon(Icons.lock),
                      labelText: 'Password',labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      icon: new Icon(Icons.lock),
                      hintText: 'Enter Your Password',
                    ),
                    /*validator: (value) {
                          if (value == null || value.isEmpty) {
                            passwordFocusNode.requestFocus();
                            return 'please enter some text';
                          }
                          if (value.length < 6) {
                            passwordFocusNode.requestFocus();
                            return 'Password must be at least 6 characters';
                          }
                        },*/


                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  minimumSize: Size(70, 50), //////// HERE
                ),
                onPressed: () {

                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      );
                    },
                  );
                  _signup();
                },
                child: Text('Register'),
              ),
            ),

            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'I have an account?',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context,'LoginPage');
                    },
                    style: Theme.of(context).textButtonTheme.style,
                    child: const Text('Login',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }



  void _signup() async{



    setState(() {
      _isSigninup = true;
    });
    String username =_usernameController.text;
    String email =_emailController.text;
    String password =_passwordController.text;

    User? user= await _auth.signUpWithEmailAndPassword(username,email,password);

    setState(() {
      _isSigninup = false;
    });

    if(_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty && _emailController.text.isNotEmpty) {
      if (user != null) {
        showToast(message: "successfully done signup");

       /*addUserDetails(
          _usernameController.text.trim(),
          _emailController.text.trim(), //(2)
        );*/
        Navigator.pushNamed(context, 'LoginPage');
      } else {
        showToast(message: "error occured in signup");
      }
    }
    else{
      showToast(message: "Please Enter the fields");
    }


  }


//adding new widget mean name,password and email code (2)
 /*Future addUserDetails(String username,String email) async{
    await FirebaseFirestore.instance.collection('users').add({
      'user name': username,
      'e-mail': email,
      'status': "unavailable",
    });
  }
  */



}