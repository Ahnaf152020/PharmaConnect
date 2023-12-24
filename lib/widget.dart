import 'package:flutter/material.dart';

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
                  'YOU ARE SUCCESFULLY LOGIN',
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
                          Navigator.pushNamed(context, 'LoginPage');
                        },
                        child: Text('GO HOME'))),
              )
            ],
          )
        ],
      ),
    );
  }
}
