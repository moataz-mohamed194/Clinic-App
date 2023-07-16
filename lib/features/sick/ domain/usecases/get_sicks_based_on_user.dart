import 'package:clinic/core/error/failures.dart';
import 'package:clinic/features/sick/%20domain/repositories/Sick_repositorie.dart';
import 'package:dartz/dartz.dart';

import '../entities/sick.dart';

class GetSickBasedOnUser {
  final SickRepository repository;

  GetSickBasedOnUser(this.repository);

  Future<Either<Failures, List<Sick>>> call() async {
    return await repository.getSickBasedOnUser();
  }
}
