import 'package:clinic/features/clinic/%20domain/entities/Clinic.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class ClinicRepository {
  Future<Either<Failures, Unit>> addClinicData(Clinic clinic);
  Future<Either<Failures, List<Clinic>>> getClinicData();
  Future<Either<Failures, Unit>> updateClinic(Clinic clinic);
}
