import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../ domain/entities/Nurse.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/string/basic.dart';
import '../models/NurseModel.dart';

abstract class NurseRemoteDataSource{

  Future<List<NurseModel>> getAllNurse();
  Future <Unit> addNurse(Nurse nurse);
}


class NurseRemoteDataSourceImple extends NurseRemoteDataSource {
  final http.Client client;

  NurseRemoteDataSourceImple({required this.client});

  @override
  Future<Unit> addNurse(Nurse nurse) async {

    final body = {
      'description': nurse.description.toString(),
      'email': nurse.email.toString(),
      'password': nurse.password.toString(),
      'userName':nurse.userName.toString(),
      'first_phone_number':nurse.firstPhoneNumber.toString(),
      'second_phone_number':nurse.secondPhoneNumber.toString()
    };
    try{
      final response = await client.post(Uri.parse(BASE_URL + '/doctor/add_nurse/'),body: body);

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
  Future<List<NurseModel>> getAllNurse() async {
    final response = await client.get(
        Uri.parse(BASE_URL+"/doctor/add_nurse/"),
        headers: {"Content-Type": "application/json"}
    );
    if (response.statusCode == 200){
      try {
        final List decodeJson = json.decode(response.body) as List;
        final List<NurseModel> nurseModel = decodeJson
            .map<NurseModel>((jsonClinicModel) =>
            NurseModel.fromJson(jsonClinicModel))
            .toList();
        return nurseModel;
      }catch(e){
        throw OfflineException();

      }
    }else{
      throw OfflineException();
    }
  }
}