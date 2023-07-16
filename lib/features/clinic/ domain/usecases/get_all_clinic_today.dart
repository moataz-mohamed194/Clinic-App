import 'package:clinic/features/clinic/%20domain/entities/Clinic.dart';
import 'package:clinic/features/clinic/%20domain/repositories/ClinicRepositorie.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetClinicData {
  final ClinicRepository repository;

  GetClinicData(this.repository);

  Future<Either<Failures, List<Clinic>>> call() async {
    return await repository.getClinicData();
  }
}
