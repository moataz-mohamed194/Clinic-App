import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/Logout.dart';
import '../../../clinic/presentation/ pages/get_clinic_data.dart';
import '../../../sick/presentation/ pages/add_sick.dart';

class MainUserPage extends StatelessWidget{
  final String name;

  const MainUserPage({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome our clint'),),
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
            title: const Text('Add medical re-examination'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> AddSickPage()));
            },
          ),
          ListTile(
            title: const Text('My old requested'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Clinic data'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> GetClinicDataPage(showAddAndEdit:false)));
            },
          ),
          ListTile(
            title: const Text('Your data'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              LogoutMethod().Logout(context: context);
            },
          ),
        ],
      ),
    );
  }
}