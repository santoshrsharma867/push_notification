import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notification/main.dart';
import 'package:push_notification/next_page.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //initilize
  static void initialize() async {
    //Android Initialization
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    //For Ios Initialization
    DarwinInitializationSettings? iosInitializationSettings =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: ((response) {
      log("foreground");
      log(response.payload.toString());

      if (response.payload.toString() == "nextpage") {
        navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) {
          return NextPage(
            id: response.payload.toString(),
          );
        }));
      }
    }));
  }

//From  firebase or Backend sent notification
  static void showNotification(RemoteMessage message) async {
    //Android
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails("notifications", "pushnotificationapp",
            priority: Priority.max, importance: Importance.max);
    //IOS
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notiDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    //This helps to show notification
    await notificationsPlugin.show(
        0, message.notification!.title, message.notification!.body, notiDetails,
        payload: message.data['id']);
  }
}
