import 'package:clinic/core/error/failures.dart';
import 'package:clinic/core/network/network_info.dart';
import 'package:clinic/features/sick/%20domain/entities/sick.dart';
import 'package:clinic/features/sick/%20domain/repositories/Sick_repositorie.dart';
import 'package:clinic/features/sick/data/datasources/sick_remote_data_source.dart';
import 'package:clinic/features/sick/data/models/SickModel.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/Exception.dart';

class SickRepositoriesImpl implements SickRepository{
  final SickRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SickRepositoriesImpl({required this.remoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failures, Unit>> addSick(Sick sick) async {
    final SickModel sickModel = SickModel(id: sick.id,
        phoneNumber: sick.phoneNumber, name: sick.name, pk: sick.pk,
        typeOfStatment: sick.typeOfStatment);
      if (await networkInfo.isConnected) {
        try {
          await remoteDataSource.addSick(sickModel);
          return Right(unit);
        }on OfflineException{
          return Left(OfflineFailures());
        }
      }else{
        return Left(OfflineFailures());
      }
  }

  @override
  Future<Either<Failures, List<Sick>>> getAllSick() async {
    if (await networkInfo.isConnected){
      try{
        final currentSick = await remoteDataSource.getSick();
        return Right(currentSick);
      }on OfflineException{
        return Left(OfflineFailures());
      }
    }else{
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, Unit>> updateSick(int id) async {
    if (await networkInfo.isConnected){
      try{
      await remoteDataSource.updateSick(id);
      return Right(unit);
      }on OfflineException{
        return Left(OfflineFailures());
      }
    }else{
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, List<Sick>>> getSickBasedOnUser() async {
    if (await networkInfo.isConnected){
      try{
        final currentSick = await remoteDataSource.getSickBasedOnUser();
        return Right(currentSick);
      }on OfflineException{
        return Left(OfflineFailures());
      }
    }else{
      return Left(OfflineFailures());
    }
  }


}