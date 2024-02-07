import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import'package:pharmaconnectbyturjo/pages/HomePage.dart';

class Anime extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Anime> {
  bool isOrderReady = false;
  void initState() {
    super.initState();
    // Start a timer to navigate back to the home page after 5 seconds
    Timer(Duration(seconds: 5), () {
      // Use Navigator to pop the current screen and return to the previous screen (home page)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Delivery",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        leading: BackButton(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/Animations/Animation - 1707321626562.json', height: 450),
          SizedBox(height: 10),
          Text(
            'Your order has been placed! Thanks for Ordering.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue, // Set your desired text color
            ),
            textAlign: TextAlign.center, // Center align the text
          ),

        ],
      ),
    );
  }
}
