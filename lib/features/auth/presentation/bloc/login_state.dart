import 'package:equatable/equatable.dart';

import '../../ domain/entities/login.dart';

abstract class LoginState extends Equatable{
  const LoginState();

  @override
  List<Object> get props => [];
}


class LoginInitial extends LoginState {}

class LoadingLoginState extends LoginState {}

class LoginMethodInitial extends LoginState {}

class LoadedLoginState extends LoginState {
  final List<Login> login;

  LoadedLoginState({required this.login});

  @override
  List<Object> get props => [login];
}

class ErrorLoginState extends LoginState {
  final String message;


  ErrorLoginState({required this.message});

  @override
  List<Object> get props => [message];
}


class MessageLoginState extends LoginState{
  final String message;

  MessageLoginState({required this.message});

  @override
  List<Object> get props => [message];
}