import 'package:clinic/features/visitor/%20domain/entities/visitor.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class VisitorRepository{
  Future<Either<Failures, List<Visitor>>> getAllVisitor();
  Future<Either<Failures, Unit>> addVisitor(Visitor visitor);
  Future<Either<Failures, Unit>> updateVisitor(int id);
}