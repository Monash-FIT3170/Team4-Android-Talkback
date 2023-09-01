import 'package:application/tutorial/five/module/winPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static Future initialize(
      BuildContext context,
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    
    DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitialize, iOS: initializationSettingsDarwin);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        // Handle the payload if necessary
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WinPage(),
          ),
        );
        return;
      },
      // Ensure you're using the right callback functions as per the plugin's documentation.
    );
  }

  static Future challengeOneNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "notification_zane",
      "channel_name",
      playSound: true,
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentSound: true,
    );

    var not = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(0, title, body, not);
  }

}

