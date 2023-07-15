import 'package:clinic/features/user/presentation/pages/add_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/string/app_color.dart';
import '../../../../core/string/app_icons.dart';
import '../../../../core/util/Logout.dart';
import '../../../clinic/presentation/ pages/get_clinic_data.dart';
import '../../../profile/presentation/page/profile.dart';
import '../../../sick/presentation/ pages/add_sick.dart';
import '../../../sick/presentation/ pages/get_sicks_based_on_user.dart';
import '../bloc/bottom_cubit.dart';

class MainUserPage extends StatelessWidget{
  final String name;

  const MainUserPage({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      GetSicksBasedOnUser(),
      GetClinicDataPage(showAddAndEdit: false),
      Profile(typeOfLogin: 'user', name: name.toString())
    ];
    return BlocBuilder<BottomCubit, int>(builder: (context, state) {
      return Scaffold(
      // appBar: AppBar(title: Text('Welcome our clint'),),

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
                  ? AppIcons.iconSelectedClinic
                  : AppIcons.iconUnSelectedClinic,
              height: 22.h,
            ),
            label: 'Clinic',
            // backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              context.read<BottomCubit>().state == 2
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
    );});
  }
}