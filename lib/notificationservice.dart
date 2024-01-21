import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings androidInitializationSettings =
  const AndroidInitializationSettings('images.png');

  void initialiseNotifications() async {// Replace with your app icon

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
     AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,  // Set the small icon name without @drawable
    );

   NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );


    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}