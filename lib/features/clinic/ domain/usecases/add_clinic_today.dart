import 'package:clinic/features/clinic/%20domain/repositories/ClinicRepositorie.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Clinic.dart';

class AddClinicData {
  final ClinicRepository repository;

  AddClinicData(this.repository);

  Future<Either<Failures, Unit>> call(Clinic clinic) async {
    return await repository.addClinicData(clinic);
  }
}
