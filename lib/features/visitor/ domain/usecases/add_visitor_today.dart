import 'package:clinic/features/visitor/%20domain/entities/visitor.dart';
import 'package:clinic/features/visitor/%20domain/repositories/Visitor_repositorie.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class AddVisitorToday{
  final VisitorRepository repository;

  AddVisitorToday(this.repository);

  Future<Either<Failures, Unit>> call(Visitor visitor) async{
    return await repository.addVisitor(visitor);
  }
}