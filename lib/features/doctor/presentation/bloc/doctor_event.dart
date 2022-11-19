
import 'package:equatable/equatable.dart';

import '../../ domain/entities/Doctor.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

class AddDoctorEvent extends DoctorEvent{
  final Doctor doctor;

  AddDoctorEvent({required this.doctor});

  @override
  List<Object> get props => [doctor];
}



class GetDoctorEvent extends DoctorEvent{}


class RefreshDoctorEvent extends DoctorEvent {}
