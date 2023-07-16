import 'package:clinic/core/error/failures.dart';

import 'package:clinic/features/fees/%20domain/entities/Fees.dart';

import 'package:dartz/dartz.dart';

import '../../ domain/repositories/FeedRepository.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/fees_remote_data_source.dart';
import '../models/FeesModel.dart';

class FeesRepositoriesImpl implements FeesRepository {
  final FeesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FeesRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, Unit>> addFeesData(Fees fees) async {
    final FeesModel feesModel = FeesModel(
        id: fees.id, type: fees.type, price: fees.price, time: fees.time);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addFeesData(feesModel);
        return Right(unit);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, Unit>> deleteFees(int feesId) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteFees(feesId);
        return Right(unit);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, List<Fees>>> getFeesDataOfDay(String day) async {
    if (await networkInfo.isConnected) {
      try {
        final currentFees = await remoteDataSource.getFeesDataOfDay(day);
        return Right(currentFees);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, List<Fees>>> getFeesDataOfMonth(String month) async {
    if (await networkInfo.isConnected) {
      try {
        final currentFees = await remoteDataSource.getFeesDataOfMonth(month);
        return Right(currentFees);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, Unit>> updateFees(Fees fees) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateFees(fees);
        return Right(unit);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }
}
