import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Nurse.dart';
import '../repositories/NurseRepository.dart';

class GetNurseData {
  final NurseRepository repository;

  GetNurseData(this.repository);

  Future<Either<Failures, List<Nurse>>> call() async {
    return await repository.getNurseData();
  }
}
