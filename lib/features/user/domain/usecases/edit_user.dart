import 'package:clinic/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repositorie.dart';

class UpdateUser {
  final UserRepository repository;

  UpdateUser(this.repository);

  Future<Either<Failures, Unit>> call(int id, User user) async {
    return await repository.updateUser(id, user);
  }
}
