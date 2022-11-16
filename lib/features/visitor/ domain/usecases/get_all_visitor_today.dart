import 'package:clinic/features/visitor/%20domain/entities/visitor.dart';
import 'package:clinic/features/visitor/%20domain/repositories/Visitor_repositorie.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetAllVisitorToday{
  final VisitorRepository repository;

  GetAllVisitorToday(this.repository);

  Future<Either<Failures, List<Visitor>>> call() async{
    return await repository.getAllVisitor();
  }
}