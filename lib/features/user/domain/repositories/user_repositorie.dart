import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failures, Unit>> addUser(User user);
  Future<Either<Failures, Unit>> updateUser(int id, User user);
}
