import 'package:clinic/core/error/failures.dart';
import 'package:clinic/features/visitor/%20domain/entities/visitor.dart';
import 'package:clinic/features/visitor/%20domain/repositories/Visitor_repositorie.dart';
import 'package:clinic/features/visitor/data/models/visitor_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/visitor_remote_data_source.dart';

class VisitorRepositoriesImpl implements VisitorRepository {
  final VisitorRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  VisitorRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, List<Visitor>>> getAllVisitor() async {
    if (await networkInfo.isConnected) {
      try {
        final currentVisitor = await remoteDataSource.getAllVisitor();
        return Right(currentVisitor);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, Unit>> addVisitor(Visitor visitor) async {
    final VisitorModel visitorModel = VisitorModel(
        id: visitor.id,
        addedByName: visitor.addedByName,
        name: visitor.name,
        reasonOfVisitor: visitor.reasonOfVisitor,
        time: visitor.time,
        approved: visitor.approved,
        addedBy: visitor.addedBy);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addVisitor(visitorModel);
        return Right(unit);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, Unit>> updateVisitor(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateVisitor(id);
        return Right(unit);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }
}
