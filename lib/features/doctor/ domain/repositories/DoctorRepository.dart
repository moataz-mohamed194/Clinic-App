import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Doctor.dart';

abstract class DoctorRepository {
  Future<Either<Failures, Unit>> addDoctorData(Doctor doctor);
  Future<Either<Failures, List<Doctor>>> getDoctorData();
}
