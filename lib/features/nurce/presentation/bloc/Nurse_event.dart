import 'package:equatable/equatable.dart';

import '../../ domain/entities/Nurse.dart';

abstract class NurseEvent extends Equatable {
  const NurseEvent();

  @override
  List<Object> get props => [];
}

class AddNurseEvent extends NurseEvent {
  final Nurse nurse;

  AddNurseEvent({required this.nurse});

  @override
  List<Object> get props => [nurse];
}

class GetNurseEvent extends NurseEvent {}

class RefreshNurseEvent extends NurseEvent {}
