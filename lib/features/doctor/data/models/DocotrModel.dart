import 'package:clinic/features/doctor/%20domain/entities/Doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel(
      {required String email,
      required String name,
      required String password,
      required int phoneNumber,
      required String description,
      String? pic})
      : super(
            email: email,
            name: name,
            password: password,
            phoneNumber: phoneNumber,
            description: description,
            pic: pic);
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        phoneNumber: json['phone_number'] ?? '',
        description: json['description'] ?? '',
        pic: json['pic'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'email': email,
      'name': name,
      'phone_number': phoneNumber,
      'description': description,
      'pic': pic
    };
  }
}
