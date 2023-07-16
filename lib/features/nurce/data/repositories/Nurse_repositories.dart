import 'package:clinic/core/error/failures.dart';
import 'package:clinic/features/nurce/%20domain/entities/Nurse.dart';
import 'package:dartz/dartz.dart';
import '../../ domain/repositories/NurseRepository.dart';
import '../../../../core/error/Exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/Nurse_remote_data_source.dart';
import '../models/NurseModel.dart';

class NurseRepositoriesImpl implements NurseRepository {
  final NurseRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  NurseRepositoriesImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, Unit>> addNurseData(Nurse nurse) async {
    final NurseModel nurseModel = NurseModel(
        email: nurse.email.toString(),
        password: nurse.password.toString(),
        description: nurse.description.toString(),
        firstPhoneNumber: nurse.firstPhoneNumber,
        userName: nurse.userName.toString(),
        secondPhoneNumber: nurse.secondPhoneNumber);
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addNurse(nurseModel);
        return Right(unit);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }

  @override
  Future<Either<Failures, List<Nurse>>> getNurseData() async {
    if (await networkInfo.isConnected) {
      try {
        final currentNurse = await remoteDataSource.getAllNurse();
        return Right(currentNurse);
      } on OfflineException {
        return Left(OfflineFailures());
      }
    } else {
      return Left(OfflineFailures());
    }
  }
}
