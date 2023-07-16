import 'package:equatable/equatable.dart';

import '../../ domain/entities/sick.dart';

abstract class AddUpdateGetSickState extends Equatable {
  const AddUpdateGetSickState();

  @override
  List<Object> get props => [];
}

class SickInitial extends AddUpdateGetSickState {}

class LoadingSicksState extends AddUpdateGetSickState {}

class LoadedSicksState extends AddUpdateGetSickState {
  final List<Sick> sicks;

  LoadedSicksState({required this.sicks});

  @override
  List<Object> get props => [sicks];
}

class ErrorSicksState extends AddUpdateGetSickState {
  final String message;

  ErrorSicksState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddUpdateGetSickState extends AddUpdateGetSickState {
  final String message;

  MessageAddUpdateGetSickState({required this.message});

  @override
  List<Object> get props => [message];
}
