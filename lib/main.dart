import 'package:clinic/features/auth/presentation/bloc/login_bloc.dart';
import 'package:clinic/features/sick/presentation/bloc/add_sick_bloc.dart';
import 'package:clinic/features/user/presentation/bloc/user_bloc.dart';
import 'package:clinic/features/visitor/presentation/bloc/add_update_visitor/add_update_visitor_bloc.dart';
import 'package:clinic/features/visitor/presentation/bloc/visitor/visitor_bloc.dart';
import 'package:clinic/core/StrogeData/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/App_Theme.dart';
import 'features/auth/presentation/ pages/LoginPage.dart';
import 'features/auth/presentation/ pages/MainDoctorPage.dart';
import 'features/auth/presentation/ pages/MainNursePage.dart';
import 'features/auth/presentation/ pages/MainUserPage.dart';
import 'features/clinic/presentation/bloc/actions_clinic_bloc.dart';
import 'features/doctor/presentation/bloc/doctor_bloc.dart';
import 'features/fees/presentation/bloc/Fees_bloc.dart';
import 'features/nurce/presentation/bloc/Nurse_bloc.dart';
import 'injection_container.dart' as di;

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  var tasksBox = await Hive.openBox<Person>('user');

    Person? loggedData = tasksBox.get(0);
    if (loggedData == null){
      runApp(MyApp());
    }else{
    runApp(MyApp(loggedData: loggedData));
  }
}

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
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            title: 'Posts App',
            // home:GetNurseDataPage()
            home:loggedData == null||loggedData!.logged == false?LoginPage():
              loggedData!.typeOfAccount == 'Nurse'?MainNursePage(name:loggedData!.name.toString()):
              loggedData!.typeOfAccount=='Doctor'?MainDoctorPage(name:loggedData!.name.toString()):
                  MainUserPage(name:loggedData!.name.toString()),
        )
    );
  }
}
