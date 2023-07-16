import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required String userName,
      required String email,
      required String password})
      : super(userName: userName, email: email, password: password);
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        userName: json['userName'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'userName': userName};
  }
}
