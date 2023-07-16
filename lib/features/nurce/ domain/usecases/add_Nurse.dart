import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/Nurse.dart';
import '../repositories/NurseRepository.dart';

class AddNurseData {
  final NurseRepository repository;

  AddNurseData(this.repository);

  Future<Either<Failures, Unit>> call(Nurse nurse) async {
    return await repository.addNurseData(nurse);
  }
}
