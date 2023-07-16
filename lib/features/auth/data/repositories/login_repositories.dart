import 'package:clinic/core/error/failures.dart';
import 'package:clinic/features/auth/%20domain/entities/login.dart';
import 'package:clinic/features/auth/%20domain/repositories/Login_repositorie.dart';
import 'package:clinic/features/auth/data/models/LoginMethod.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/login_remote_date_source.dart';

class LoginRepositoriesImpl extends LoginRepositorie{
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoriesImpl({required this.remoteDataSource,required this.networkInfo});

  @override
  Future<Either<Failures, Unit>> loginMethod(Login login, bool stayLogin) async {
    final LoginMethod loginMethod = LoginMethod(
      email: login.email, password: login.password
    );
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.loginMethod(loginMethod, stayLogin);
        return Right(unit);
      }catch(e){
        return Left(FailuresLoginFailures());
      }
    }else{
      return Left(OfflineFailures());
    }
  }

}