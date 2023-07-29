import 'package:clinic/core/StrogeData/hive.dart';
import 'package:clinic/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/injection/injection_container.dart' as di;
import 'my_app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
Future<void> messageHandler(RemoteMessage message) async {
  print('notification from background : ${message.data}');

}

void firebaseMessagingListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('notification from foreground : ${message.data}');

  });
}
void main() async{

  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  RequestConfiguration config = RequestConfiguration(
      testDeviceIds: <String>['C9A7F9E228F8DC93C8418E719C763B33']
  );
  MobileAds.instance.updateRequestConfiguration(config);

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  var tasksBox = await Hive.openBox<Person>('user');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  firebaseMessagingListener();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  print('User granted permission: ${settings.authorizationStatus}');
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('token: ${fcmToken}');

  Person? loggedData = tasksBox.get(0);
    if (loggedData == null){
      runApp(MyApp());
    }else{
    runApp(MyApp(loggedData: loggedData));
  }
}
