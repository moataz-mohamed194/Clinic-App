import 'dart:convert';

import 'package:clinic/core/error/Exception.dart';
import 'package:clinic/features/visitor/%20domain/entities/visitor.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../../../core/StrogeData/hive.dart';
import '../../../../core/string/url.dart';
import '../models/visitor_model.dart';

abstract class VisitorRemoteDataSource{
  Future<List<VisitorModel>> getAllVisitor();
  Future<Unit> updateVisitor(int id);
  Future <Unit> addVisitor(Visitor visitor);
}


class VisitorRemoteDataSourceImpl implements VisitorRemoteDataSource{

  final http.Client client;

  VisitorRemoteDataSourceImpl({required this.client});

  @override
  Future<List<VisitorModel>> getAllVisitor() async{
    final response = await client.get(
      Uri.parse(AppUrl.UrlAddVisitor),
      headers: {"Content-Type": "application/json"}
    );
    if (response.statusCode == 200){
      final List decodeJson = json.decode(response.body) as List;
      final List<VisitorModel> visitorModels = decodeJson
          .map<VisitorModel>((jsonVisitorModel) => VisitorModel.fromJson(jsonVisitorModel))
          .toList();
      return visitorModels;
    }else{
      throw OfflineException();
    }
  }


  @override
  Future<Unit> addVisitor(Visitor visitor) async{
    var tasksBox = await Hive.openBox<Person>('user');

    final body = {
      'name': visitor.name.toString(),
      'reason_of_visitor': visitor.reasonOfVisitor.toString(),

      'pk': tasksBox.get(0)!.pk.toString()
    };
    try{
    final response = await client.post(Uri.parse(AppUrl.UrlAddVisitor),body: body);


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
  Future<Unit> updateVisitor(int id) async{
    final body = {
      'pk': id.toString()
    };
    final response = await client.patch(
      Uri.parse(AppUrl.UrlApproveVisitor),body: body
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw OfflineException();
    }
  }
  
}