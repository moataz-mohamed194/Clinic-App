import 'package:equatable/equatable.dart';

import '../../ domain/entities/Clinic.dart';

abstract class AddUpdateGetClinicState extends Equatable{
  const AddUpdateGetClinicState();

  @override
  List<Object> get props => [];
}

class ClinicInitial extends AddUpdateGetClinicState {}

class LoadingClinicState extends AddUpdateGetClinicState {}


class LoadedClinicState extends AddUpdateGetClinicState {
  final List<Clinic> clinic;

  LoadedClinicState({required this.clinic});

  @override
  List<Object> get props => [clinic];
}

class ErrorClinicState extends AddUpdateGetClinicState {
  final String message;


  ErrorClinicState({required this.message});

  @override
  List<Object> get props => [message];
}


class MessageAddUpdateGetClinicState extends AddUpdateGetClinicState{
  final String message;

  MessageAddUpdateGetClinicState({required this.message});

  @override
  List<Object> get props => [message];
}