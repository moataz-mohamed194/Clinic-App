import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../clinic/presentation/ pages/get_clinic_data.dart';
import '../../../sick/presentation/ pages/add_sick.dart';

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
              Navigator.push(context, MaterialPageRoute(builder: (_)=> AddSickPage()));
            },
          ),
          ListTile(
            title: const Text('The visitors'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Clinic data'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> GetClinicDataPage(showAddAndEdit:true)));

            },
          ),
        ],
      ),
    );
  }
}