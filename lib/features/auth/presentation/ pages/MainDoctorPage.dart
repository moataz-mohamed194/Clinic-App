import 'package:clinic/core/string/app_color.dart';
import 'package:clinic/core/string/app_icons.dart';
import 'package:clinic/features/doctor/presentation/%20pages/get_all_doctors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../../core/locale/app_localizations.dart';
import '../../../../core/string/language.dart';
import '../../../../core/util/Logout.dart';
import '../../../clinic/presentation/ pages/get_clinic_data.dart';
import '../../../fees/presentation/ pages/choose_date_page.dart';
import '../../../profile/presentation/page/profile.dart';
import '../../../sick/presentation/ pages/get_all_sicks.dart';
import '../../../visitor/presentation/ pages/get_all_visitors.dart';
import '../bloc/bottom_cubit.dart';

class MainDoctorPage extends StatelessWidget {
  final String name;
  MainDoctorPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      GetAllSicksPage(typeOfLogin: 'doctor'),
      GetAllVisitors(typeOfLogin: 'doctor'),
      GetClinicDataPage(showAddAndEdit: true),
      Profile(typeOfLogin: 'doctor', name: name.toString())
    ];
    return BlocBuilder<BottomCubit, int>(builder: (context, state) {
      return Scaffold(
        // appBar: AppBar(title: Text('Welcome Doctor'),),
        body: Center(
          child: _widgetOptions.elementAt(context.read<BottomCubit>().state),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(context.read<BottomCubit>().state == 0
                  ? AppIcons.iconSelectedHome
                  : AppIcons.iconUnSelectedHome,
                height: 22.h,),
              label: 'Home',
              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(context.read<BottomCubit>().state == 1
                  ? AppIcons.iconSelectedVisitor
                  : AppIcons.iconUnSelectedVisitor,
                height: 22.h,),
              label: 'Visitor',
              // backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(context.read<BottomCubit>().state == 2
                  ? AppIcons.iconSelectedClinic
                  : AppIcons.iconUnSelectedClinic,
                height: 22.h,),
              label: 'Clinic',
              // backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                context.read<BottomCubit>().state == 3
                    ? AppIcons.iconSelectedAvatar
                    : AppIcons.iconUnSelectedAvatar,
      height: 22.h,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: state,
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.grey.shade500,
          showUnselectedLabels: true,
          // useLegacyColorScheme: true,
          onTap: context.read<BottomCubit>().changeCurrentPage,
        ),
        drawer: _drawerBody(context, this.name.toString()),
      );
    });
  }

  _drawerBody(BuildContext context, String name) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(name.toString()),
            ),
          ),
          // ListTile(
          //   title: const Text("Waiting for the doctor's examination"),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (_)=> GetAllSicksPage(typeOfLogin:'doctor')));
          //   },
          // ),
          // ListTile(
          //   title: Text('The visitors'),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (_)=> GetAllVisitors(typeOfLogin:'doctor')));
          //   },
          // ),
          // ListTile(
          //   title: Text('The Doctors'),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (_)=> GetDoctorDataPage()));
          //   },
          // ),
          // ListTile(
          //   title: const Text('Clinic data'),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (_)=> GetClinicDataPage(showAddAndEdit:true)));
          //
          //   },
          // ),
          // ListTile(
          //   title: const Text('Fees of day'),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (_)=> ChooseDatePage(isItDay: true,)));
          //
          //   },
          // ),
          // ListTile(
          //   title: const Text('Fees of month'),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (_)=> ChooseDatePage(isItDay: false,)));
          //
          //   },
          // ),

          Container(
            width: 100,
            child: ToggleSwitch(
              initialLabelIndex: 0,
              totalSwitches: 2,
              activeBgColor: [Colors.greenAccent],
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
          // ListTile(
          //   title: const Text('Logout'),
          //   onTap: () {
          //     LogoutMethod().logout(context: context);
          //   },
          // ),
        ],
      ),
    );
  }
}
