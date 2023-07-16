import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Nurse.dart';

abstract class NurseRepository {
  Future<Either<Failures, Unit>> addNurseData(Nurse nurse);
  Future<Either<Failures, List<Nurse>>> getNurseData();
}
