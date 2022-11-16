import 'package:clinic/core/error/failures.dart';
import 'package:clinic/features/sick/%20domain/entities/sick.dart';
import 'package:clinic/features/sick/%20domain/repositories/Sick_repositorie.dart';
import 'package:dartz/dartz.dart';

class GetAllSick{
  final SickRepository repository;

  GetAllSick( this.repository);

  Future<Either<Failures, List<Sick>>> call()async{
    return await repository.getAllSick();
  }

}