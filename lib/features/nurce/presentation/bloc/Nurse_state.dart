import 'package:equatable/equatable.dart';

import '../../ domain/entities/Nurse.dart';

abstract class AddGetNurseState extends Equatable {
  const AddGetNurseState();

  @override
  List<Object> get props => [];
}

class NurseInitial extends AddGetNurseState {}

class LoadingNurseState extends AddGetNurseState {}

class LoadedNurseState extends AddGetNurseState {
  final List<Nurse> nurse;

  LoadedNurseState({required this.nurse});

  @override
  List<Object> get props => [nurse];
}

class ErrorNurseState extends AddGetNurseState {
  final String message;

  ErrorNurseState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddGetNurseState extends AddGetNurseState {
  final String message;

  MessageAddGetNurseState({required this.message});

  @override
  List<Object> get props => [message];
}
