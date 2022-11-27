
import 'package:clinic/core/error/failures.dart';

import 'package:clinic/features/user/domain/entities/user.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/Exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/user_repositorie.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/UserModel.dart';

class UserRepositoriesImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, Unit>> addUser(User user) async {
    final UserModel userModel = UserModel(
        userName: user.userName, email: user.email, password: user.password);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addUser(userModel);
        return Right(unit);
      }on OfflineException{
        return Left(OfflineFailures());
      }
    }else{
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, Unit>> updateUser(int id, User user) async {
    final UserModel userModel = UserModel(
        userName: user.userName, email: user.email, password: user.password);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateUser(id, userModel);
        return Right(unit);
      }on OfflineException{
        return Left(OfflineFailures());
      }
    }else{
      return Left(OfflineFailures());
    }
  }
}