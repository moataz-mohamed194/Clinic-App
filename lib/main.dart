import 'package:clinic/core/StrogeData/hive.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/injection/injection_container.dart' as di;
import 'my_app.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  RequestConfiguration config = RequestConfiguration(
      testDeviceIds: <String>['C9A7F9E228F8DC93C8418E719C763B33']
  );
  MobileAds.instance.updateRequestConfiguration(config);

  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  var tasksBox = await Hive.openBox<Person>('user');

    Person? loggedData = tasksBox.get(0);
    if (loggedData == null){
      runApp(MyApp());
    }else{
    runApp(MyApp(loggedData: loggedData));
  }
}
