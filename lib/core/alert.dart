import 'package:clinic/core/string/app_color.dart';
import 'package:clinic/core/string/app_icons.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  static Widget globalAlertWidget(
      BuildContext context, String title, String body) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          backgroundColor: AppColors.mainColor,
          message: "$title\n $body",
          icon: Image.asset(AppIcons.iconClinicLog),
        ),
      );
    });
    return Container();
  }
}
