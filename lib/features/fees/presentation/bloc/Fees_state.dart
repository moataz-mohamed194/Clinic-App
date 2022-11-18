import 'package:equatable/equatable.dart';

import '../../ domain/entities/Fees.dart';


abstract class AddUpdateGetFeesState extends Equatable{
  const AddUpdateGetFeesState();

  @override
  List<Object> get props => [];
}

class FeesInitial extends AddUpdateGetFeesState {}

class LoadingFeesState extends AddUpdateGetFeesState {}


class LoadedFeesState extends AddUpdateGetFeesState {
  final List<Fees> fees;

  LoadedFeesState({required this.fees});

  @override
  List<Object> get props => [fees];
}

class ErrorFeesState extends AddUpdateGetFeesState {
  final String message;


  ErrorFeesState({required this.message});

  @override
  List<Object> get props => [message];
}


class MessageAddUpdateGetFeesState extends AddUpdateGetFeesState{
  final String message;

  MessageAddUpdateGetFeesState({required this.message});

  @override
  List<Object> get props => [message];
}