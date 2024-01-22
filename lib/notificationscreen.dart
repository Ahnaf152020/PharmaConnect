import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  //Map<String, String?> payload = {};
  const NotificationScreen({
    Key?key,
    required this.payload,


  }) : super(key: key)  ;
  final String payload;
  @override
  Widget build(BuildContext context) {
   // payload = ModalRoute.of(context)?.settings.arguments as Map<String, String?>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Text('This is a notification page! $payload', style: TextStyle(fontSize: 25)),
      ),
    );
  }
}