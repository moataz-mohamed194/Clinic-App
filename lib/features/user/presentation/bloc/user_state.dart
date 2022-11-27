import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';


abstract class AddUpdateUserState extends Equatable{
  const AddUpdateUserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends AddUpdateUserState {}

class LoadingUsersState extends AddUpdateUserState {}


class LoadedUsersState extends AddUpdateUserState {
  final List<User> user;

  LoadedUsersState({required this.user});

  @override
  List<Object> get props => [user];
}

class ErrorUsersState extends AddUpdateUserState {
  final String message;


  ErrorUsersState({required this.message});

  @override
  List<Object> get props => [message];
}


class MessageAddUpdateUserState extends AddUpdateUserState{
  final String message;

  MessageAddUpdateUserState({required this.message});

  @override
  List<Object> get props => [message];
}