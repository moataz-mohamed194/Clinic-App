import 'package:clinic/core/error/failures.dart';
import 'package:clinic/features/sick/%20domain/repositories/Sick_repositorie.dart';
import 'package:dartz/dartz.dart';

class UpdateSick {
  final SickRepository repository;

  UpdateSick(this.repository);

  Future<Either<Failures, Unit>> call(int id) async {
    return await repository.updateSick(id);
  }
}
