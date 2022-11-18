import 'package:clinic/core/error/failures.dart';
import 'package:clinic/features/clinic/%20domain/entities/Clinic.dart';
import 'package:clinic/features/clinic/%20domain/repositories/ClinicRepositorie.dart';
import 'package:clinic/features/clinic/data/models/ClinicModel.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/clinic_remote_data_source.dart';

class ClinicRepositoriesImpl implements ClinicRepository{
  final ClinicRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ClinicRepositoriesImpl({required this.remoteDataSource,
    required this.networkInfo});

  @override
  Future<Either<Failures, Unit>> addClinicData(Clinic clinic) async {
    final ClinicModel clinicModel = ClinicModel(id: clinic.id,
         addrees: clinic.addrees,
         note: clinic.note,
         fromTime: clinic.fromTime,
         toTime: clinic.toTime, timeOfVacation: clinic.timeOfVacation);
    if (await networkInfo.isConnected){
      try{
        await remoteDataSource.addClinic(clinicModel);
        return Right(unit);
      }on OfflineException{
        return Left(OfflineFailures());
      }
    }else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, List<Clinic>>> getClinicData() async {
    if(await networkInfo.isConnected) {
      try{
        final currentClinic = await remoteDataSource.getAllClinic();
        return Right(currentClinic);
      }on OfflineException{
        return Left(OfflineFailures());
      }
    }else{
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, Unit>> updateClinic(Clinic clinic) async {
    if (await networkInfo.isConnected){
      try{
        await remoteDataSource.updateClinic(clinic);
        // await remoteDataSource.updateClinic(id);
        return Right(unit);
      }on OfflineException{
        return Left(OfflineFailures());
      }
    }else {
      return Left(OfflineFailures());
    }
  }

}