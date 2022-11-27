import 'package:clinic/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repositorie.dart';

class AddUser{
  final UserRepository repository;

  AddUser(this.repository);

  Future<Either<Failures, Unit>> call(User user) async{
    return await repository.addUser(user);
  }
}