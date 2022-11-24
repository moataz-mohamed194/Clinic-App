import 'package:clinic/core/error/failures.dart';
import 'package:clinic/features/sick/%20domain/entities/sick.dart';
import 'package:dartz/dartz.dart';

import '../repositories/Sick_repositorie.dart';

class AddSickReport{
  final SickRepository repository;

  AddSickReport(this.repository);

  Future<Either<Failures, Unit>> call(int id, String report) async{
    return await repository.addSickReport(id, report);
  }
}