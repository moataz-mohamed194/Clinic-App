
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/sick.dart';

abstract class SickRepository{
  Future<Either<Failures, List<Sick>>> getAllSick();
  Future<Either<Failures, Unit>> addSick(Sick sick);
  Future<Either<Failures, Unit>> updateSick(int id);
  Future<Either<Failures, Unit>> addSickReport(int id, String report);

  Future<Either<Failures,List<Sick>>> getSickBasedOnUser();
}