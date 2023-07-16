import 'package:clinic/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_bloc.dart';
import 'package:clinic/features/user/presentation/bloc/user_bloc.dart';
import 'package:clinic/features/visitor/presentation/bloc/add_update_visitor/add_update_visitor_bloc.dart';
import 'package:clinic/features/visitor/presentation/bloc/visitor/visitor_bloc.dart';
import 'package:clinic/core/StrogeData/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/App_Theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/injection/injection_container.dart';
import 'generated/l10n.dart';
import 'features/auth/presentation/ pages/LoginPage.dart';
import 'features/auth/presentation/ pages/MainDoctorPage.dart';
import 'features/auth/presentation/ pages/MainNursePage.dart';
import 'features/auth/presentation/ pages/MainUserPage.dart';
import 'features/auth/presentation/bloc/bottom_cubit.dart';
import 'features/auth/presentation/bloc/check_box_cubit.dart';
import 'features/auth/presentation/bloc/eyes_cubit.dart';
import 'features/clinic/presentation/bloc/actions_clinic_bloc.dart';
import 'features/doctor/presentation/ pages/add_doctor.dart';
import 'features/doctor/presentation/ pages/get_all_doctors.dart';
import 'features/doctor/presentation/bloc/doctor_bloc.dart';
import 'features/fees/presentation/ pages/choose_date_page.dart';
import 'features/fees/presentation/bloc/Fees_bloc.dart';
import 'features/nurce/presentation/bloc/Nurse_bloc.dart';
import 'core/injection/injection_container.dart' as di;
import 'features/profile/presentation/bloc/locale_cubit.dart';
import 'features/sick/presentation/ pages/add_sick.dart';
import 'features/visitor/presentation/ pages/add_visitor.dart';

class MyApp extends StatelessWidget {
  final Person? loggedData;

  const MyApp({Key? key, this.loggedData}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
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
        child:
    BlocProvider<LocaleCubit>(
    create: (context) =>LocaleCubit(cubitLanguage: loggedData==null?'en':loggedData!.language??'ar', changeLanguageUseCase: sl()),
    // di.sl<LocaleCubit>()..add(GetSickEvent()),
       child: BlocBuilder<LocaleCubit, String>(builder: (context, state) {
       return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          locale: Locale(state),
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
              builder: (context, widget) =>loggedData == null||loggedData!.logged == false?LoginPage():
              loggedData!.typeOfAccount == 'Nurse'?MainNursePage(data:loggedData!):
              loggedData!.typeOfAccount=='Doctor'?MainDoctorPage(data:loggedData!):
              MainUserPage(data:loggedData!),
          ),
          // localeResolutionCallback:
          // AppLocalizationsSetup.localeResolutionCallback,
        );}))
    );
  }
}
