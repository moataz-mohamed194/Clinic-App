import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clinic/features/clinic/%20domain/entities/Clinic.dart';
import 'package:clinic/features/clinic/data/models/ClinicModel.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/string/url.dart';

abstract class ClinicRemoteDataSource {
  Future<List<ClinicModel>> getAllClinic();
  Future<Unit> updateClinic(Clinic clinic);
  Future<Unit> addClinic(Clinic clinic);
}

class ClinicRemoteDataSourceImple extends ClinicRemoteDataSource {
  final http.Client client;

  ClinicRemoteDataSourceImple({required this.client});

  @override
  Future<List<ClinicModel>> getAllClinic() async {
    final response = await client.get(Uri.parse(AppUrl.UrlGetClinicsData),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      try {
        final List decodeJson = json.decode(response.body) as List;
        final List<ClinicModel> clinicModels = decodeJson
            .map<ClinicModel>(
                (jsonClinicModel) => ClinicModel.fromJson(jsonClinicModel))
            .toList();
        return clinicModels;
      } catch (e) {
        throw OfflineException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> addClinic(Clinic clinic) async {
    final body = {
      'address': clinic.addrees.toString(),
      'note': clinic.note.toString(),
      'time_of_vacation': clinic.timeOfVacation.toString(),
      'from_time': clinic.fromTime.toString(),
      'to_time': clinic.toTime.toString(),
      'latitude': clinic.latitude.toString(),
      'longitude': clinic.longitude.toString(),
    };
    try {
      final response =
          await client.post(Uri.parse(AppUrl.UrlModelOfClinic), body: body);

      if (response.statusCode == 201 ||
          response.body == '{"Results": "Success request"}') {
        return Future.value(unit);
      } else {
        throw OfflineException();
      }
    } catch (e) {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> updateClinic(Clinic clinic) async {
    final body = {
      'address': clinic.addrees.toString(),
      'note': clinic.note.toString(),
      'time_of_vacation': clinic.timeOfVacation.toString(),
      'from_time': clinic.fromTime.toString(),
      'to_time': clinic.toTime.toString(),
      'pk': clinic.id.toString(),
      'latitude': clinic.latitude.toString(),
      'longitude': clinic.longitude.toString(),
    };
    final response =
        await client.patch(Uri.parse(AppUrl.UrlEditDataClinic), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw OfflineException();
    }
  }
}
