import 'package:clinic/core/StrogeData/hive.dart' as hive;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/App_Theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/alert.dart';
import 'core/bloc/global_alert_bloc.dart';
import 'core/injection/injection_container.dart';
import 'generated/l10n.dart';
import 'features/auth/presentation/ pages/LoginPage.dart';
import 'features/auth/presentation/ pages/MainDoctorPage.dart';
import 'features/auth/presentation/ pages/MainNursePage.dart';
import 'features/auth/presentation/ pages/MainUserPage.dart';
import 'features/profile/presentation/bloc/locale_cubit.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class MyApp extends StatelessWidget {
  final hive.Person? loggedData;

  MyApp({this.loggedData});

  @override
  Widget build(BuildContext context) {
    AlertAlertFire.initializeFirebaseMessaging(context);
    return BlocProvider<LocaleCubit>(
        create: (context) => LocaleCubit(
            cubitLanguage:
                loggedData == null ? 'en' : loggedData!.language ?? 'ar',
            changeLanguageUseCase: sl()),
        // di.sl<LocaleCubit>()..add(GetSickEvent()),
        child: BlocBuilder<LocaleCubit, String>(builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            locale: state == null ? Locale('en') : Locale(state),
            title: 'Posts App',
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, widget0) {
                return Stack(
                  children: [
                    loggedData == null || loggedData!.logged == false
                        ? LoginPage()
                        : loggedData!.typeOfAccount == 'Nurse'
                            ? MainNursePage(data: loggedData!)
                            : loggedData!.typeOfAccount == 'Doctor'
                                ? MainDoctorPage(data: loggedData!)
                                : MainUserPage(data: loggedData!),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: BlocBuilder<GlobalAlertBloc, GlobalAlertState>(
                            builder: (context, state) {
                           if(state.isAlertVisible== true) {
                               AlertAlertFire.globalAlertWidget(
                              context:context,title: state.title ?? '', body:state.body ?? '', fln:flutterLocalNotificationsPlugin);
                            }
                          return SizedBox.shrink();
                        }),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }));
  }
}

// Create the BLoC
