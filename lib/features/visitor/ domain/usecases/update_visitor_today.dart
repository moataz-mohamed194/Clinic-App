import 'package:clinic/features/visitor/%20domain/repositories/Visitor_repositorie.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class UpdateVisitorToday{
  final VisitorRepository repository;

  UpdateVisitorToday(this.repository);

  Future<Either<Failures, Unit>> call(int id) async{
    return await repository.updateVisitor(id);
  }
}