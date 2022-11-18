import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Fees.dart';
import '../repositories/FeedRepository.dart';

class GetFeesOfDay{
  final FeesRepository repository;

  GetFeesOfDay(this.repository);

  Future<Either<Failures, List<Fees>>> call(String day) async{
    return await repository.getFeesDataOfDay(day);
  }
}