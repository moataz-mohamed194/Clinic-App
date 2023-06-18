import 'dart:convert';

import 'package:clinic/features/doctor/%20domain/entities/Doctor.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/Exception.dart';
import '../../../../core/string/basic.dart';
import '../models/DocotrModel.dart';

abstract class DoctorRemoteDataSource{
  Future<List<DoctorModel>> getAllDoctor();
  Future <Unit> addDoctor(Doctor doctor);
}


class DoctorRemoteDataSourceImple extends DoctorRemoteDataSource {
  final http.Client client;

  DoctorRemoteDataSourceImple({required this.client});

  @override
  Future<Unit> addDoctor(Doctor doctor) async {

    final body = {
      'name': doctor.name.toString(),
      'email': doctor.email.toString(),
      'password': doctor.password.toString(),
      'phone_number':doctor.phoneNumber.toString(),
      'description':doctor.description.toString(),
      'pic':doctor.pic.toString()
    };
    try{
      final response = await client.post(Uri.parse(AppUrl.UrlModelOfClinic),body: body);

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
  Future<List<DoctorModel>> getAllDoctor() async {
    final response = await client.get(
        Uri.parse(AppUrl.UrlModelOfClinic),
        headers: {"Content-Type": "application/json"}
    );
    if (response.statusCode == 200){
      try {
        final List decodeJson = json.decode(response.body) as List;
        final List<DoctorModel> doctorModels = decodeJson
            .map<DoctorModel>((jsonClinicModel) =>
            DoctorModel.fromJson(jsonClinicModel))
            .toList();
        return doctorModels;
      }catch(e){
        throw OfflineException();

      }
    }else{
      throw OfflineException();
    }
  }

}