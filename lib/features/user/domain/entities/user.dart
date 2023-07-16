import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userName;
  final String email;
  final String password;

  User({required this.userName, required this.email, required this.password});

  @override
  List<Object?> get props => [userName, email, password];
}
