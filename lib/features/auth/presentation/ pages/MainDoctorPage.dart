import 'package:clinic/features/doctor/presentation/%20pages/get_all_doctors.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/Logout.dart';
import '../../../clinic/presentation/ pages/get_clinic_data.dart';
import '../../../fees/presentation/ pages/choose_date_page.dart';
import '../../../sick/presentation/ pages/add_sick.dart';
import '../../../sick/presentation/ pages/get_all_sicks.dart';
import '../../../visitor/presentation/ pages/get_all_visitors.dart';

class MainDoctorPage extends StatelessWidget{
  final String name;

  const MainDoctorPage({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome Doctor'),),
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
              Navigator.push(context, MaterialPageRoute(builder: (_)=> GetAllSicksPage(typeOfLogin:'doctor')));
            },
          ),
          ListTile(
            title: Text('The visitors'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> GetAllVisitors(typeOfLogin:'doctor')));
            },
          ),
          ListTile(
            title: Text('The Doctors'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> GetDoctorDataPage()));
            },
          ),
          ListTile(
            title: const Text('Clinic data'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> GetClinicDataPage(showAddAndEdit:true)));

            },
          ),
          ListTile(
            title: const Text('Fees of day'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> ChooseDatePage(isItDay: true,)));

            },
          ),
          ListTile(
            title: const Text('Fees of month'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> ChooseDatePage(isItDay: false,)));

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