import 'package:clinic/features/auth/presentation/%20pages/LoginPage.dart';
import 'package:clinic/features/auth/presentation/%20pages/MainNursePage.dart';
import 'package:clinic/features/auth/presentation/bloc/login_bloc.dart';
import 'package:clinic/features/clinic/presentation/bloc/actions_clinic_event.dart';
import 'package:clinic/features/sick/presentation/%20pages/get_all_sicks.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_bloc.dart';
import 'package:clinic/features/visitor/presentation/bloc/add_update_visitor/add_update_visitor_bloc.dart';
import 'package:clinic/features/visitor/presentation/bloc/visitor/visitor_bloc.dart';
import 'package:clinic/core/StrogeData/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/App_Theme.dart';
import 'features/auth/presentation/ pages/MainUserPage.dart';
import 'features/clinic/presentation/ pages/get_clinic_data.dart';
import 'features/clinic/presentation/bloc/actions_clinic_bloc.dart';
import 'features/sick/presentation/ pages/add_sick.dart';
import 'features/sick/presentation/bloc/add_sick_event.dart';
import 'features/visitor/presentation/ pages/get_all_visitors.dart';
import 'injection_container.dart' as di;
void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final batteryBox =
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_)=> di.sl<AddUpdateGetClinicBloc>()..add(GetClinicEvent())
          ),
          BlocProvider(
              create: (_)=> di.sl<AddUpdateGetSickBloc>()..add(GetSickEvent())
          ),
          BlocProvider(
              create: (_)=> di.sl<VisitorBloc>()..add(GetAllVisitorsEvent())
          ),
          BlocProvider(create: (_)=> di.sl<AddUpdateVisitorBloc>()),
          BlocProvider(create: (_)=> di.sl<LoginBloc>()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            title: 'Posts App',
          // TODO:: ADD THE CHECK OF LOGIN WHERE IF LOGGED BEFORE GO TO HIS PART
          home:LoginPage(),
        )
    );
  }
}
