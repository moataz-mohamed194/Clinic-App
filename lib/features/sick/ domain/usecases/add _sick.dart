import 'package:clinic/core/error/failures.dart';
import 'package:clinic/features/sick/%20domain/entities/sick.dart';
import 'package:dartz/dartz.dart';

import '../repositories/Sick_repositorie.dart';

class AddSick {
  final SickRepository repository;

  AddSick(this.repository);

  Future<Either<Failures, Unit>> call(Sick sick) async {
    return await repository.addSick(sick);
  }
}
