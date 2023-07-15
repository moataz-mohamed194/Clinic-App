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
              icon: Image.asset(
                context.read<BottomCubit>().state == 0
                    ? AppIcons.iconSelectedHome
                    : AppIcons.iconUnSelectedHome,
                height: 22.h,
              ),
              label: 'Home',
              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                context.read<BottomCubit>().state == 1
                    ? AppIcons.iconSelectedVisitor
                    : AppIcons.iconUnSelectedVisitor,
                height: 22.h,
              ),
              label: 'Visitor',
              // backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                context.read<BottomCubit>().state == 2
                    ? AppIcons.iconSelectedClinic
                    : AppIcons.iconUnSelectedClinic,
                height: 22.h,
              ),
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
      );
    });
  }

}
