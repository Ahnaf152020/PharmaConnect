import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class forgotPasswordScreen extends StatefulWidget {
  const forgotPasswordScreen({super.key});

  @override
  State<forgotPasswordScreen> createState() => _forgotPasswordScreenState();
}

class _forgotPasswordScreenState extends State<forgotPasswordScreen> {

    final emailController =TextEditingController();
    final auth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),

      ),
      body: Padding(
            padding:  const  EdgeInsets.symmetric(horizontal: 20),

      child :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:  CrossAxisAlignment.center,

        children: <Widget>[
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'E-mail'
            ),
          ),
          SizedBox(height: 40,),

          ElevatedButton(
            child: Text(
                "Buy now".toUpperCase(),
                style: TextStyle(fontSize: 14)
            ),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Colors.red)
                    )
                )
            ), onPressed: () {
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                print('We have sent you e-mail to recover password,please check your email');
              }).onError((error, stackTrace){
                print(error.toString());
              });
          },
          ),

            ],
      )
      ),
    );
  }
}
