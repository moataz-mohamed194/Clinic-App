import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Fees.dart';
import '../repositories/FeedRepository.dart';

class AddFees{
  final FeesRepository repository;

  AddFees(this.repository);

  Future<Either<Failures, Unit>> call(Fees fees) async{
    return await repository.addFeesData(fees);
  }
}