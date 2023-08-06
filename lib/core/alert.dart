
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'bloc/global_alert_bloc.dart';

class AlertAlertFire {
  // Method to initialize the Firebase Cloud Messaging and handle FCM messages
  static void initializeFirebaseMessaging(BuildContext context) {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle incoming FCM messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(message.notification!.title);
      print(message.notification!.body);
      BlocProvider.of<GlobalAlertBloc>(context).add(GlobalAlertShowEvent(
          title: message.notification!.title ?? '',
          body: message.notification!.body ?? ''));
    });
  }

  // Widget to show the global alert
  static Future<Widget> globalAlertWidget(
      {required BuildContext context,
        required String title,
        required String body,
      required FlutterLocalNotificationsPlugin fln}) async {
      AndroidNotificationDetails androidPlatformChannelSpecifics =
      new AndroidNotificationDetails(
        'clinic_app_notification',
        'channel_name',

        playSound: true,
        sound: RawResourceAndroidNotificationSound('cough'),
        importance: Importance.high,
        priority: Priority.high,
      );

      var not= NotificationDetails(android: androidPlatformChannelSpecifics
      );
      await fln.show(0, title, body,not );
    return Container();
  }
}
