import 'dart:convert';

import 'package:clinic/core/StrogeData/hive.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart' as http;
import '../../ domain/entities/sick.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/string/url.dart';
import '../models/SickModel.dart';

abstract class SickRemoteDataSource {
  Future<Unit> addSick(Sick sick);
  Future<Unit> addSickReport(int? id, String report);
  Future<Unit> updateSick(int id);
  Future<Unit> updateSickAsEntered(int id);
  Future<List<SickModel>> getSickBasedOnUser();
  Future<List<SickModel>> getSick();
}

class SickRemoteDataSourceImple extends SickRemoteDataSource {
  final http.Client client;

  SickRemoteDataSourceImple({required this.client});
  @override
  Future<Unit> addSick(Sick sick) async {
    var tasksBox = await Hive.openBox<Person>('user');

    final body = {
      'name': sick.name.toString(),
      'type_of_statement': sick.typeOfStatment.toString(),
      'phone_number': sick.phoneNumber.toString(),
      'pk': tasksBox.get(0)!.pk.toString()
    };
    try {
      final response =
          await client.post(Uri.parse(AppUrl.UrlAddBooking), body: body);

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
  Future<List<SickModel>> getSick() async {
    final response = await client.get(Uri.parse(AppUrl.UrlAddBooking),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      try {
        final List decodeJson = json.decode(response.body) as List;
        final List<SickModel> sickModels = decodeJson
            .map<SickModel>(
                (jsonSickModel) => SickModel.fromJson(jsonSickModel))
            .toList();
        return sickModels;
      } catch (e) {
        throw OfflineException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> updateSick(int id) async {
    var tasksBox = await Hive.openBox<Person>('user');

    final body = {
      'row_pk': id.toString(),
      'user_pk': tasksBox.get(0)!.pk.toString()
    };
    final response = await client
        .patch(Uri.parse(AppUrl.UrlApproveBookingForSick), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> updateSickAsEntered(int id) async {
    final response =
        await client.patch(Uri.parse(AppUrl.UrlEnteredSick(id.toString())));
    if (response.statusCode == 201 ||
        response.body == '{"Results": "Success request"}') {
      return Future.value(unit);
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<List<SickModel>> getSickBasedOnUser() async {
    var tasksBox = await Hive.openBox<Person>('user');
    String id = tasksBox.get(0)!.pk.toString();
    final response =
        await client.get(Uri.parse(AppUrl.UrlGetAllBookingRequisted('$id')));
    if (response.statusCode == 200) {
      final List decodeJson = json.decode(response.body) as List;
      final List<SickModel> sickModels = decodeJson
          .map<SickModel>((jsonSickModel) => SickModel.fromJson(jsonSickModel))
          .toList();
      return sickModels;
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> addSickReport(int? id, String report) async {
    final body = {'pk': id.toString(), 'doctor_report': report.toString()};
    try {
      final response =
          await client.patch(Uri.parse(AppUrl.UrlAddReportForSick), body: body);

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
}
