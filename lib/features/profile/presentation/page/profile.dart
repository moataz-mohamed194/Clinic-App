import 'package:clinic/core/string/app_color.dart';
import 'package:clinic/core/string/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/locale/app_localizations.dart';
import '../../../../core/string/app_images.dart';
import '../../../../core/string/language.dart';
import '../../../../core/util/Logout.dart';
import '../../../../core/widgets/widget_app_bar.dart';
import '../../../doctor/presentation/ pages/get_all_doctors.dart';
import '../../../fees/presentation/ pages/choose_date_page.dart';

class Profile extends StatelessWidget {
  final String? typeOfLogin;
  final String? name;

  const Profile({Key? key, this.typeOfLogin, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          WidgetAppBar(context: context, title: 'Profile', showHomeIcon: true),
      // _buildAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.only(top: 25),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppImages.imagePerson),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              name.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            typeOfLogin == 'doctor'
                ? Card(
                    child: ListTile(
                      leading: Container(
                        child: Image.asset(AppIcons.iconSubscription),
                        alignment: Alignment.center,
                        width: 30.w,
                        height: MediaQuery.of(context).size.height,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChooseDatePage(
                                      isItDay: false,
                                    )));
                      },
                      title: Text('Fees of month'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  )
                : Container(),
            typeOfLogin == 'doctor'
                ? Card(
                    child: ListTile(
                      leading: Container(
                        child: Image.asset(AppIcons.iconHand),
                        alignment: Alignment.center,
                        width: 30.w,
                        height: MediaQuery.of(context).size.height,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChooseDatePage(
                                      isItDay: true,
                                    )));
                      },
                      title: Text('Fees of day'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  )
                : Container(),
            typeOfLogin == 'doctor' || typeOfLogin == 'nurse'
                ? Card(
                    child: ListTile(
                      leading: Container(
                        child: Image.asset(AppIcons.iconDoctor2),
                        alignment: Alignment.center,
                        width: 30.w,
                        height: MediaQuery.of(context).size.height,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => GetDoctorDataPage()));
                      },
                      title: Text('The Doctors'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  )
                : Container(),
            Container(
              // width: 100,
              child: ToggleSwitch(
                initialLabelIndex: 0,
                totalSwitches: 2,
                activeBgColor: [AppColors.mainColor],
                activeFgColor: Colors.white,
                labels: [
                  AppLocalizations.of(context)!.translate(AppLanguage.english) ??
                      '',
                  AppLocalizations.of(context)!.translate(AppLanguage.arabic) ??
                      ''
                ],
                onToggle: (index) {
                  print('dddddd:$index');
                  print(AppLocalizations.of(context)!.isEnLocale);
                  //   if (AppLocalizations.of(context)!.isEnLocale) {
                  //     if (index == 0) {
                  //       context.read<LocaleCubit>().toEnglish();
                  //     } else {
                  //       context.read<LocaleCubit>().toArabic();
                  //     }
                  //   } else {
                  //     if (index == 1) {
                  //       context.read<LocaleCubit>().toEnglish();
                  //     } else {
                  //       context.read<LocaleCubit>().toArabic();
                  //     }
                  //   }
                },
              ),
            ),

            SizedBox(
              height: 15,
            ),
            Card(
                    child: ListTile(
                      leading: Container(
                        child: Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                        width: 30.w,
                        height: MediaQuery.of(context).size.height,
                      ),
                      onTap: () {
                        LogoutMethod().logout(context: context);
                      },
                      title: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                      // trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      );
}
