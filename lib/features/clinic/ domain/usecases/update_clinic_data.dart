import 'package:clinic/features/clinic/%20domain/repositories/ClinicRepositorie.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/Clinic.dart';

class UpdateClinicData{
  final ClinicRepository repository;

  UpdateClinicData(this.repository);

  Future<Either<Failures, Unit>> call(Clinic clinic) async{
    return await repository.updateClinic(clinic);
  }
  // Future<Either<Failures, Unit>> call(int id) async{
  //   return await repository.updateClinic(id);
  // }
}