import 'package:clinic/features/auth/%20domain/entities/login.dart';

class LoginMethod extends Login {
  LoginMethod({required String email, required String password})
      : super(email: email, password: password);

  factory LoginMethod.fromJson(Map<String, dynamic> json) {
    return LoginMethod(email: json['email'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
