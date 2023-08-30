import 'package:clinic/core/string/app_icons.dart';
import 'package:clinic/features/auth/presentation/%20pages/MainNursePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../core/StrogeData/hive.dart';
import '../../../../core/string/app_color.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/widget_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../user/presentation/pages/add_user.dart';
import '../bloc/login/login_bloc.dart';
import '../widgets/form_widget.dart';
import 'MainDoctorPage.dart';
import 'MainUserPage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(context: context, doNotShowBackButton: true),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(AppIcons.iconHealthCare),
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) async {
                    if (state is MessageLoginState) {
                      SnackBarMessage().showSuccesSnackBar(
                          message: state.message, context: context);
                      var tasksBox = await Hive.openBox<Person>('user');
                      if (tasksBox.get(0)!.typeOfAccount == 'Nurse') {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) =>
                                    MainNursePage(data: tasksBox.get(0)!)),
                            (route) => false);
                      } else if (tasksBox.get(0)!.typeOfAccount == 'Doctor') {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) =>
                                    MainDoctorPage(data: tasksBox.get(0)!)),
                            (route) => false);
                      } else if (tasksBox.get(0)!.typeOfAccount == 'User') {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) =>
                                    MainUserPage(data: tasksBox.get(0)!)),
                            (route) => false);
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) =>
                                    MainUserPage(data: tasksBox.get(0)!)),
                            (route) => false);
                      }
                    } else if (state is ErrorLoginState) {
                      SnackBarMessage().showErrorSnackBar(
                          message: state.message, context: context);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingLoginState) {
                      return LoadingWidget();
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FormWidget(context:context),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                            )),
                            Text(
                              '    ${S.of(context).OrContinueWith}    ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Expanded(
                                child: Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.shade300,
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1.0,
                                          style:
                                              BorderStyle.solid), //Border.all
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Image(
                                      image: AssetImage(AppIcons.iconFaceBook),
                                      width: 10,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    width: 40,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1.0,
                                          style:
                                              BorderStyle.solid), //Border.all
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Image.asset(AppIcons.iconGoogle),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    width: 40,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1.0,
                                          style:
                                              BorderStyle.solid), //Border.all
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Image.asset(AppIcons.iconAppleLogo),
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20)),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).DonnotHaveAccount,
                              style: TextStyle(color: Colors.grey),
                            ),
                            InkWell(
                              child: Text(
                                S.of(context).CreateAccount,
                                style: TextStyle(
                                  color: AppColors.mainColor,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => AddUserPage(
                                          isItAdd: true,
                                        )));
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
