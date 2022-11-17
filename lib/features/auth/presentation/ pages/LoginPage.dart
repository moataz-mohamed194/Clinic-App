import 'package:clinic/features/auth/presentation/%20pages/MainNursePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/StrogeData/hive.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../widgets/form_widget.dart';
import 'MainDoctorPage.dart';
import 'MainUserPage.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Login'),),
          body: _body(context),
        )
    );
  }
  Widget _body(BuildContext context){
    return  Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) async {
              if (state is MessageLoginState){

                SnackBarMessage().showSuccesSnackBar(message: state.message, context: context);
                var tasksBox = await Hive.openBox<Person>('user');
                if (tasksBox.get(0)!.typeOfAccount == 'Nurse'){
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => MainNursePage(name:tasksBox.get(0)!.name.toString())),
                          (route) => false);
                }else if (tasksBox.get(0)!.typeOfAccount == 'Doctor'){

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => MainDoctorPage(name:tasksBox.get(0)!.name.toString())),
                          (route) => false);
                }else if (tasksBox.get(0)!.typeOfAccount == 'User'){
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => MainUserPage(name:tasksBox.get(0)!.name.toString())),
                          (route) => false);
                } else{
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => MainUserPage(name:tasksBox.get(0)!.name.toString())),
                          (route) => false);
                }
              }else if (state is ErrorLoginState){

                SnackBarMessage().showErrorSnackBar(message: state.message, context: context);

              }
            },
            builder: (context, state){
              if (state is LoadingLoginState){
                return LoadingWidget();
              }
              return FormWidget();

            },

          ),
        ),
      );

  }
}