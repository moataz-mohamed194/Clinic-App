import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/login.dart';

abstract class LoginRepositorie{
  Future<Either<Failures, Unit>> loginMethod(Login login);
}