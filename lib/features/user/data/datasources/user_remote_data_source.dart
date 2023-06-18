import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/Exception.dart';
import '../../../../core/string/basic.dart';
import '../../domain/entities/user.dart';

abstract class UserRemoteDataSource{
  Future<Unit> addUser(User user);
  Future<Unit> updateUser(int id, User user);
 
}

class UserRemoteDataSourceImple extends UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImple({ required this.client});

  @override
  Future<Unit> addUser(User user) async {

    final body = {
      'email': user.email.toString(),
      'password': user.password.toString(),
      'userName': user.userName.toString(),
    };
    try{
      final response = await client.post(Uri.parse(AppUrl.UrlAddAccount),body: body);
      if (response.statusCode == 201 || response.body == '{"Results": "Success request"}'){
        return Future.value(unit);
      }else{
        throw OfflineException();
      }}
    catch(e){
      throw OfflineException();
    }
  }

  @override
  Future<Unit> updateUser(int id, User user) async {
    final body = {
      'email': user.email.toString(),
      'userName': user.userName.toString(),
    };
    try{
      final response = await client.post(Uri.parse(AppUrl.UrlUpdateAccount(id.toString())),body: body);
      if (response.statusCode == 201 || response.body == '{"Results": "Success request"}'){
        return Future.value(unit);
      }else{
        throw OfflineException();
      }
    }
    catch(e){
      throw OfflineException();
    }
  }
}