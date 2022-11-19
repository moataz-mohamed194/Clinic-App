import 'package:clinic/features/doctor/%20domain/entities/Doctor.dart';
import 'package:clinic/features/doctor/%20domain/repositories/DoctorRepository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetDoctorData{
  final DoctorRepository repository;

  GetDoctorData(this.repository);

  Future<Either<Failures, List<Doctor>>> call() async{
    return await repository.getDoctorData();
  }
}