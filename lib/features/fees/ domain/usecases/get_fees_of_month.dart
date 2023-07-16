import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Fees.dart';
import '../repositories/FeedRepository.dart';

class GetFeesOfMonth {
  final FeesRepository repository;

  GetFeesOfMonth(this.repository);

  Future<Either<Failures, List<Fees>>> call(String month) async {
    return await repository.getFeesDataOfMonth(month);
  }
}
