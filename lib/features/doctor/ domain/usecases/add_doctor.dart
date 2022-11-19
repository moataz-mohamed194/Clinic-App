import 'package:clinic/features/doctor/%20domain/repositories/DoctorRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Doctor.dart';

class AddDoctorData{
  final DoctorRepository repository;

  AddDoctorData(this.repository);

  Future<Either<Failures, Unit>> call(Doctor doctor) async{
    return await repository.addDoctorData(doctor);
  }
}