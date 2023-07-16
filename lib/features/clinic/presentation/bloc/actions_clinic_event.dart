import 'package:equatable/equatable.dart';

import '../../ domain/entities/Clinic.dart';

abstract class ClinicEvent extends Equatable {
  const ClinicEvent();

  @override
  List<Object> get props => [];
}

class AddClinicEvent extends ClinicEvent {
  final Clinic clinic;

  AddClinicEvent({required this.clinic});

  @override
  List<Object> get props => [clinic];
}

class UpdateClinicEvent extends ClinicEvent {
  final Clinic clinic;

  UpdateClinicEvent({required this.clinic});

  @override
  List<Object> get props => [clinic];
}

class GetClinicEvent extends ClinicEvent {}

class RefreshClinicEvent extends ClinicEvent {}
