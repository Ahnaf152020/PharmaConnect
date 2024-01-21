import 'package:flutter/material.dart';
import 'package:pharmaconnectbyturjo/notificationscreen.dart';
import 'package:pharmaconnectbyturjo/notificationservice.dart';
import 'package:pharmaconnectbyturjo/toast.dart';
import 'package:pharmaconnectbyturjo/pages/Update_Profile.dart';

class Mywidget extends StatefulWidget {
  const Mywidget({Key? key}) : super(key: key);

  @override
  State<Mywidget> createState() => _MywidgetState();
}

class _MywidgetState extends State<Mywidget> {
  NotificationService notification = NotificationService();

@override
void initState(){
  super.initState();
  notification.initialiseNotifications();
}
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
                        Navigator.pushNamed(context, 'LoginPage');
                        showToast(message: 'you are succesfully home');
                      },
                      //child: Text('GO HOME'),
                      child: Text('GO Home'),
                    )),

              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 400.0),
                child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'chatsearchpage');
                        showToast(message: 'you are on PharmaConnect ChatBox');
                      },
                      //child: Text('GO HOME'),
                      child: Text('Chat Box'),
                    )),

              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 450.0),
                child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'HomePage');
                        showToast(message: 'you are successfully on Home Page');
                      },
                      //child: Text('GO HOME'),
                      child: Text('GO to Home Page'),
                    )),

              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 500.0),
                child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showToast(message: 'you are logged Out');
                      },

                      child: Text('Log Out'),
                    )),

              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 550.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: ElevatedButton(
                      child: Text('Notify'),
                      onPressed: () {
                       // notification.sendNotification("this is a message", "this is a body");
                        Navigator.pushNamed(context, 'notificationpage');
                       // Navigator.push(context,MaterialPageRoute(builder: (context) => ()));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
