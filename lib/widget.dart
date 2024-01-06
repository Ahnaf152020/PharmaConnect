import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/chatsearchpage.dart';
import 'package:pharmaconnectbyturjo/pages/LoginPage.dart';
import 'package:pharmaconnectbyturjo/toast.dart';
import 'package:provider/provider.dart';

import 'firebase.dart';

final FirebaseAuth _auth=FirebaseAuth.instance;
class Mywidget extends StatefulWidget {
  const Mywidget({Key? key}) : super(key: key);

  @override
  State<Mywidget> createState() => _MywidgetState();
}

class _MywidgetState extends State<Mywidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 300, left: 80.0),
                child: Text(
                  'YOU ARE SUCCESFULLY DONE IT',
                  style: TextStyle(backgroundColor: Colors.orange),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 350.0),
                child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                       MaterialPageRoute(
                           builder: (context) => chatpage()),
                             );
                        },
                        child: Text('Chat Room'))),
              )
            ],
          )
        ],
      ),
    );
  }
}
