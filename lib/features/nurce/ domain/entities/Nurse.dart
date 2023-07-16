import 'package:equatable/equatable.dart';

class Nurse extends Equatable {
  final String userName;
  final String email;
  final String password;
  final int firstPhoneNumber;
  var secondPhoneNumber;
  final String description;

  Nurse(
      {required this.userName,
      required this.email,
      required this.password,
      required this.firstPhoneNumber,
      this.secondPhoneNumber,
      required this.description});

  @override
  List<Object?> get props => [
        userName,
        email,
        password,
        firstPhoneNumber,
        secondPhoneNumber,
        description
      ];
}
