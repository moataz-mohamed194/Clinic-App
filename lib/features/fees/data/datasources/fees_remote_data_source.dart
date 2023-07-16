import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../ domain/entities/Fees.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/string/url.dart';
import '../models/FeesModel.dart';

abstract class FeesRemoteDataSource {
  Future<List<FeesModel>> getFeesDataOfDay(String day);
  Future<List<FeesModel>> getFeesDataOfMonth(String month);
  Future<Unit> updateFees(Fees fees);
  Future<Unit> deleteFees(int id);
  Future<Unit> addFeesData(Fees fees);
}

class FeesRemoteDataSourceImple extends FeesRemoteDataSource {
  final http.Client client;

  FeesRemoteDataSourceImple({required this.client});

  @override
  Future<Unit> addFeesData(Fees fees) async {
    final body = {
      'price': fees.price.toString(),
      'type': fees.type.toString(),
      'time': fees.time.toString()
    };
    try {
      final response =
          await client.post(Uri.parse(AppUrl.UrlAddFees), body: body);
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
  Future<Unit> deleteFees(int id) async {
    final body = {'pk': id.toString()};
    try {
      final response = await client
          .delete(Uri.parse(AppUrl.UrlFeesUpdateDeleteGet), body: body);

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
  Future<List<FeesModel>> getFeesDataOfDay(String day) async {
    final response = await client.get(
      Uri.parse(AppUrl.UrlGetFeesOfDay(day.toString())),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      try {
        final List decodeJson = json.decode(response.body) as List;
        final List<FeesModel> feesModels = decodeJson
            .map<FeesModel>(
                (jsonClinicModel) => FeesModel.fromJson(jsonClinicModel))
            .toList();
        return feesModels;
      } catch (e) {
        throw OfflineException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<List<FeesModel>> getFeesDataOfMonth(String month) async {
    final response = await client.get(
      Uri.parse(AppUrl.UrlGetFeesOfMonth(month.toString())),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      try {
        final List decodeJson = json.decode(response.body) as List;
        final List<FeesModel> feesModels = decodeJson
            .map<FeesModel>(
                (jsonClinicModel) => FeesModel.fromJson(jsonClinicModel))
            .toList();
        return feesModels;
      } catch (e) {
        throw OfflineException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> updateFees(Fees fees) async {
    final body = {
      'price': fees.price.toString(),
      'type': fees.type.toString(),
      'time': fees.time.toString(),
      'pk': fees.id.toString()
    };
    try {
      final response = await client
          .patch(Uri.parse(AppUrl.UrlFeesUpdateDeleteGet), body: body);
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
