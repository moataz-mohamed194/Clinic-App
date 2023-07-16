import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Fees.dart';

abstract class FeesRepository {
  Future<Either<Failures, Unit>> addFeesData(Fees fees);
  Future<Either<Failures, List<Fees>>> getFeesDataOfDay(String day);
  Future<Either<Failures, List<Fees>>> getFeesDataOfMonth(String month);
  Future<Either<Failures, Unit>> updateFees(Fees fees);
  Future<Either<Failures, Unit>> deleteFees(int feesId);
}
