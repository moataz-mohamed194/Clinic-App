import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../main.dart';
import '../../my_app.dart';
import '../StrogeData/hive.dart';

class LogoutMethod{
  Future<void> logout({required BuildContext context}) async {
    var tasksBox = await Hive.openBox<Person>('user');
    tasksBox.get(0)!.logged = false;
    tasksBox.get(0)!.save();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => MyApp(loggedData: tasksBox.get(0),)), (route) => false);

  }
}