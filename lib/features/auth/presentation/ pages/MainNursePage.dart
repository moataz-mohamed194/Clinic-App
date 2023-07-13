import 'package:clinic/features/sick/presentation/%20pages/get_all_sicks.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/util/Logout.dart';
import '../../../clinic/presentation/ pages/get_clinic_data.dart';
import '../../../visitor/presentation/ pages/get_all_visitors.dart';

class MainNursePage extends StatelessWidget{
  final String name;

    MainNursePage({Key? key,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome Nurse'),),
      drawer: _drawerBody(context, this.name.toString()),
    );
  }
  _drawerBody(BuildContext context, String name){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(child: Text(name.toString()),),
          ),
          ListTile(
            title: const Text("Waiting for the doctor's examination"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> GetAllSicksPage(typeOfLogin:'nurse')));
            },
          ),
          ListTile(
            title: const Text('The visitors'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> GetAllVisitors()));
            },
          ),
          ListTile(
            title: const Text('Clinic data'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> GetClinicDataPage(showAddAndEdit:false)));
            },
          ),
          ToggleSwitch(
            initialLabelIndex: 0,
            totalSwitches: 2,
            activeBgColor: [Colors.greenAccent],
            activeFgColor: Colors.white,
            labels: ['aa','ww'],
            onToggle: (index) {
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
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              LogoutMethod().logout(context: context);
            },
          ),
        ],
      ),
    );
  }
}