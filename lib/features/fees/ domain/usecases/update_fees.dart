import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Fees.dart';
import '../repositories/FeedRepository.dart';

class UpdateFeesData {
  final FeesRepository repository;

  UpdateFeesData(this.repository);

  Future<Either<Failures, Unit>> call(Fees fees) async {
    return await repository.updateFees(fees);
  }
}
