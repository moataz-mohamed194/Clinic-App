import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/FeedRepository.dart';

class DeleteFeesData{
  final FeesRepository repository;

  DeleteFeesData(this.repository);

  Future<Either<Failures, Unit>> call(int feesID) async{
    return await repository.deleteFees(feesID);
  }
}