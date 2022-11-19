
import 'package:equatable/equatable.dart';

import '../../ domain/entities/Doctor.dart';

abstract class AddGetDoctorState extends Equatable{
  const AddGetDoctorState();

  @override
  List<Object> get props => [];
}

class DoctorInitial extends AddGetDoctorState {}

class LoadingDoctorState extends AddGetDoctorState {}


class LoadedDoctorState extends AddGetDoctorState {
  final List<Doctor> doctor;

  LoadedDoctorState({required this.doctor});

  @override
  List<Object> get props => [doctor];
}

class ErrorDoctorState extends AddGetDoctorState {
  final String message;


  ErrorDoctorState({required this.message});

  @override
  List<Object> get props => [message];
}


class MessageAddGetDoctorState extends AddGetDoctorState{
  final String message;

  MessageAddGetDoctorState({required this.message});

  @override
  List<Object> get props => [message];
}