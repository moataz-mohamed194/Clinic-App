import 'package:clinic/core/string/app_color.dart';
import 'package:clinic/core/string/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/StrogeData/hive.dart';
import '../../../../core/string/app_images.dart';
import '../../../../core/util/Logout.dart';
import '../../../../core/widgets/widget_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../doctor/presentation/ pages/get_all_doctors.dart';
import '../../../fees/presentation/ pages/choose_date_page.dart';
import '../bloc/locale_cubit.dart';

class Profile extends StatelessWidget {
  final Person? data;

  const Profile({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
          context: context, title: S.of(context).Profile, showHomeIcon: true),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.only(top: 25),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppImages.imagePerson),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              data!.name.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: ToggleSwitch(
                initialLabelIndex: data!.language == 'en' ? 0 : 1,
                totalSwitches: 2,
                activeBgColor: [AppColors.mainColor],
                activeFgColor: Colors.white,
                labels: [S.of(context).english, S.of(context).arabic],
                onToggle: (index) {
                  if (index == 0) {
                    context.read<LocaleCubit>().toEnglish();
                  } else {
                    context.read<LocaleCubit>().toArabic();
                  }
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            data!.typeOfAccount.toString() == 'Doctor'
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
                      title: Text(S.of(context).FeesOfMonth),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  )
                : Container(),
            data!.typeOfAccount.toString() == 'Doctor'
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
                      title: Text(S.of(context).FeesOfDay),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  )
                : Container(),
            data!.typeOfAccount.toString() == 'Doctor' ||
                    data!.typeOfAccount.toString() == 'nurse'
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
                      title: Text(S.of(context).TheDoctors),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  )
                : Container(),
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
                  S.of(context).Logout,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
