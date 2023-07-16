import 'package:clinic/core/string/app_color.dart';
import 'package:clinic/core/string/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/StrogeData/hive.dart';
import '../../../../generated/l10n.dart';
import '../../../clinic/presentation/ pages/get_clinic_data.dart';
import '../../../profile/presentation/page/profile.dart';
import '../../../sick/presentation/ pages/get_all_sicks.dart';
import '../../../visitor/presentation/ pages/get_all_visitors.dart';
import '../bloc/bottom_cubit.dart';

class MainDoctorPage extends StatelessWidget {
  final Person data;
  MainDoctorPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      GetAllSicksPage(typeOfLogin: 'Doctor'),
      GetAllVisitors(typeOfLogin: 'Doctor'),
      GetClinicDataPage(showAddAndEdit: true),
      Profile( data: data)
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
              label: S.of(context).Home,
              // backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                context.read<BottomCubit>().state == 1
                    ? AppIcons.iconSelectedVisitor
                    : AppIcons.iconUnSelectedVisitor,
                height: 22.h,
              ),
              label:  S.of(context).Visitor,
              // backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                context.read<BottomCubit>().state == 2
                    ? AppIcons.iconSelectedClinic
                    : AppIcons.iconUnSelectedClinic,
                height: 22.h,
              ),
              label:  S.of(context).Clinic,
              // backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                context.read<BottomCubit>().state == 3
                    ? AppIcons.iconSelectedAvatar
                    : AppIcons.iconUnSelectedAvatar,
                height: 22.h,
              ),
              label:  S.of(context).Profile,
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
