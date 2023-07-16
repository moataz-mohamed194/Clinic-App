part of 'add_update_visitor_bloc.dart';

abstract class AddUpdateVisitorState extends Equatable {
  const AddUpdateVisitorState();

  @override
  List<Object> get props => [];
}

class AddUpdateVisitorInitial extends AddUpdateVisitorState {}

class LoadingAddUpdateVisitorState extends AddUpdateVisitorState {}

class ErrorAddUpdateVisitorState extends AddUpdateVisitorState {
  final String message;

  ErrorAddUpdateVisitorState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddUpdateVisitorState extends AddUpdateVisitorState {
  final String message;

  MessageAddUpdateVisitorState({required this.message});

  @override
  List<Object> get props => [message];
}
