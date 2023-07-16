import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String email;
  final String password;

  Login({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}
