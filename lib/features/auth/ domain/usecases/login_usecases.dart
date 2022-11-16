import 'package:clinic/core/error/failures.dart';
import 'package:clinic/features/auth/%20domain/repositories/Login_repositorie.dart';
import 'package:dartz/dartz.dart';

import '../entities/login.dart';

class LoginUseCases{
  final LoginRepositorie repositorie;

  LoginUseCases( this.repositorie);

  Future<Either<Failures, Unit>> call(Login login) async{
    return await repositorie.loginMethod(login);
  }
}