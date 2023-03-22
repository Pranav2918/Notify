import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _plugin.initialize(initializationSettings);
  }

  //HeadsUp Notification Method
  static Future<void> display(RemoteMessage message) async {
    try {
      var random =
          Random(); // keep this somewhere in a static variable. Just make sure to initialize only once.
      int id = random.nextInt(pow(2, 31) - 1 as int);

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "pushnotificationapp",
        "pushnotificationappchannel",
        importance: Importance.max,
        priority: Priority.high,
      ));

      //Show Notification...
      await _plugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: message.data["route"]);
    } on Exception catch (e) {
      print(e);
    }
  }
}
