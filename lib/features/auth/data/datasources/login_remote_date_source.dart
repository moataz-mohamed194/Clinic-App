import 'dart:convert';

import 'package:clinic/core/string/basic.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';

import '../../ domain/entities/login.dart';
import '../../../../core/StrogeData/hive.dart';
import '../../../../core/error/Exception.dart';

abstract class LoginRemoteDataSource{
  Future<Unit> loginMethod(Login login);
}

class LoginRemoteDataSourceImple extends LoginRemoteDataSource{
  final http.Client client;

  LoginRemoteDataSourceImple({required this.client});

  @override
  Future<Unit> loginMethod(Login login) async {
    print('login method');
    final body ={
      'email': login.email.toString(),
      'password': login.password.toString()
    };
    try{
      final response = await client.post(
        Uri.parse(BASE_URL+'/users/login/'),
        body: body
      );
      if (response.statusCode == 201 || response.statusCode == 200 ){
          Map valueMap = json.decode(response.body);
          var addData = await Hive.openBox<Person>('user');
          var person = Person()
            ..typeOfAccount = valueMap['typeOfAccount']
            ..pk = valueMap['pk'].toString()
            ..logged = true
            ..name = valueMap['name'];
        try{
          addData.putAt(0, person);
          return Future.value(unit);
        }catch(e){
          addData.add(person);
          return Future.value(unit);
        }
      }else{
        throw FailuresLoginException();
      }
    }catch(e){
      print(e);
      throw OfflineException();

    }
  }

}