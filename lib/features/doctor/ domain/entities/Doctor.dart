import 'package:equatable/equatable.dart';

class Doctor extends Equatable{
  final String email;
  final String name;
  final String password;
  final int phoneNumber;
  final String description;
  final String? pic;

  Doctor({required this.email,
    required  this.name,
    required  this.password,
    required this.phoneNumber,
    required this.description,
    this.pic});

  @override
  // TODO: implement props
  List<Object?> get props => [email, name, password,
    phoneNumber, description, pic];
}