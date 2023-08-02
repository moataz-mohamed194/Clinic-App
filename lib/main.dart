import 'package:clinic/core/StrogeData/hive.dart' as hive;
import 'package:clinic/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'core/bloc/global_alert_bloc.dart';
import 'core/injection/injection_container.dart' as di;
import 'features/auth/presentation/bloc/login/login_bloc.dart';
import 'features/profile/presentation/bloc/locale_cubit.dart';
import 'features/sick/presentation/bloc/add_sick_bloc.dart';
import 'features/user/presentation/bloc/user_bloc.dart';
import 'features/visitor/presentation/bloc/add_update_visitor/add_update_visitor_bloc.dart';
import 'features/visitor/presentation/bloc/visitor/visitor_bloc.dart';
import 'my_app.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'features/auth/presentation/bloc/bottom_cubit.dart';
import 'features/auth/presentation/bloc/check_box_cubit.dart';
import 'features/auth/presentation/bloc/eyes_cubit.dart';
import 'features/clinic/presentation/bloc/actions_clinic_bloc.dart';
import 'features/doctor/presentation/bloc/doctor_bloc.dart';
import 'features/fees/presentation/bloc/Fees_bloc.dart';
import 'features/nurce/presentation/bloc/Nurse_bloc.dart';
import 'core/injection/injection_container.dart' as di;
void main() async{

  await Hive.initFlutter();
  Hive.registerAdapter(hive.PersonAdapter());
  RequestConfiguration config = RequestConfiguration(
      testDeviceIds: <String>['C9A7F9E228F8DC93C8418E719C763B33']
  );
  MobileAds.instance.updateRequestConfiguration(config);

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  var tasksBox = await Hive.openBox<hive.Person>('user');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  hive.Person? loggedData = tasksBox.get(0);

    runApp(MultiBlocProvider(
        providers: [
          BlocProvider<GlobalAlertBloc>(create: (_) => GlobalAlertBloc()),

          BlocProvider(create: (_)=> di.sl<AddUpdateGetFeesBloc>()),
          BlocProvider(create: (_)=> di.sl<AddGetDoctorBloc>()),
          BlocProvider(create: (_)=> di.sl<AddUpdateGetSickBloc>()),
          BlocProvider(create: (_)=> di.sl<VisitorBloc>()),
          BlocProvider(create: (_)=> di.sl<AddUpdateGetClinicBloc>()),
          BlocProvider(create: (_)=> di.sl<AddUpdateVisitorBloc>()),
          BlocProvider(create: (_)=> di.sl<LoginBloc>()),
          BlocProvider(create: (_)=> di.sl<AddGetNurseBloc>()),
          BlocProvider(create: (_)=> di.sl<AddUpdateUserBloc>()),
          BlocProvider(create: (_)=> di.sl<EyesCubit>()),
          BlocProvider(create: (_)=> di.sl<CheckBoxCubit>()),
          BlocProvider(create: (_)=> di.sl<BottomCubit>()),
          BlocProvider(create: (_)=> di.sl<LocaleCubit>()),
        ],
        child:loggedData == null?MyApp(): MyApp(loggedData: loggedData)
    ));
  }

