import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pharmaconnectbyturjo/notificationscreen.dart';
import 'package:pharmaconnectbyturjo/notificationservice.dart';
import 'package:pharmaconnectbyturjo/toast.dart';

class NotificationHome extends StatefulWidget {
  const NotificationHome ({ Key? key}):super(key: key);

  @override
  State<NotificationHome> createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {

  late final LocalNotificationService service;

  void initState() {
    service = LocalNotificationService();
    service.initialize();
    ListenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Notification '),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await service.showNotification(
                          id: 0,
                          title: 'PharmaConnect',
                          body: 'Welcome to PharmaConnect App User.');
                    },
                    child: const Text('Show Local Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showScheduledNotification(
                        id: 0,
                        title: 'PharmaConnect',
                        body: 'Welcome to PharmaConnect App User. \n You will find various medical products  available in our app.',

                        seconds: 1,
                      );
                    },
                    child: const Text('Show Scheduled Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showNotificationWithPayload(
                        id: 0,
                        title: 'PharmaConnect',
                        body: 'Hello! User',
                        payload: 'Welcome to PharmaConnect App You have some payload notifications.',
                      );
                    },
                    child: const Text('Show  Notification With Payload'),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void ListenToNotification() =>
      service.onNotificationClick.stream.listen(onNotifiactionListener);

  void onNotifiactionListener(String ? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      Navigator.push(
          context, MaterialPageRoute(builder: (
              (context) => NotificationScreen(payload:payload ))));
    }
  }
}
