import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/StrogeData/hive.dart';
import '../../../../core/error/Exception.dart';

abstract class BaseLanguageLocaleDataSource {
  Future<String> changeLanguage({required String languageCode});

}

class LanguageLocaleDataSource implements BaseLanguageLocaleDataSource {
  final SharedPreferences sharedPreferences;

  const LanguageLocaleDataSource({required this.sharedPreferences});

  @override
  Future<String> changeLanguage({required String languageCode}) async {
    try {
      // await sharedPreferences.setString(AppStrings.locale, languageCode);
      var addData = await Hive.openBox<Person>('user');

      Person? valueFromTheBox = addData.getAt(0); // "stringText"

      var person = Person()
        ..typeOfAccount = valueFromTheBox!.typeOfAccount
        ..pk = valueFromTheBox.pk.toString()
        ..logged = valueFromTheBox.logged
        ..language = languageCode
        ..name = valueFromTheBox.name;
      addData.putAt(0, person);
      print('data hive typeOfAccount:${addData.values.first.typeOfAccount}');
      print('data hive pk:${addData.values.first.pk}');
      print('data hive logged:${addData.values.first.logged}');
      print('data hive language:${addData.values.first.language}');
      print('data hive name:${addData.values.first.name}');
      return Future.value(languageCode);

    }catch(e){
      throw OfflineException();

    }
  }

}
