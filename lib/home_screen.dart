import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification/main.dart';
import 'next_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This token have to pass to login api or whatever just for saving Id to
  //database for send notification to particualr device
  String deviceTokenToSendPushNotification = '';
  String platformType = "";

  @override
  void initState() {
    super.initState();
    getDeviceTokenToSendNotification();
    notificationFromBackendOrFirebase();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token $deviceTokenToSendPushNotification");
  }

  notificationFromBackendOrFirebase() {
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          if (message.data['id'] != null) {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //       builder: (context) => NextPage(
            //             id: message.data['id'],
            //           )),
            // );

            navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) {
              return NextPage(
                id: message.data['id'],
              );
            }));
          }
        }
      },
    );
// 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          // NotificationService.showNotification(message);
        }
      },
    );

// 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        log("background");
        print("Background");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['id']}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
              onTap: () {
                // NotificationService.showNotificationTest();
              },
              child: Icon(Icons.notification_add))),
    );
  }
}
