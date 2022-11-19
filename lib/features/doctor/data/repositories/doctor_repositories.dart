
import 'package:clinic/core/error/failures.dart';

import 'package:clinic/features/doctor/%20domain/entities/Doctor.dart';
import 'package:clinic/features/doctor/data/models/DocotrModel.dart';

import 'package:dartz/dartz.dart';

import '../../ domain/repositories/DoctorRepository.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/doctor_remote_data_source.dart';

class DoctorRepositoriesImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  DoctorRepositoriesImpl({required this.remoteDataSource,
    required this.networkInfo});

  @override
  Future<Either<Failures, Unit>> addDoctorData(Doctor doctor) async {
    final DoctorModel doctorModel = DoctorModel(
        email: doctor.email.toString(),
        name: doctor.name.toString(),
        password: doctor.password.toString(),
        phoneNumber: doctor.phoneNumber,
        description: doctor.description.toString(),
        pic: doctor.pic.toString()
    );
    if (await networkInfo.isConnected){
      try{
        await remoteDataSource.addDoctor(doctorModel);
        return Right(unit);
      }on OfflineException{
        return Left(OfflineFailures());
      }
    }else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, List<Doctor>>> getDoctorData() async {
    if(await networkInfo.isConnected) {
      try{
        final currentDoctor = await remoteDataSource.getAllDoctor();
        return Right(currentDoctor);
      }on OfflineException{
        return Left(OfflineFailures());
      }
    }else{
      return Left(OfflineFailures());
    }
  }
}