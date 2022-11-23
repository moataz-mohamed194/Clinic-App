import 'package:clinic/features/nurce/%20domain/entities/Nurse.dart';

class NurseModel extends Nurse{
  NurseModel({required String userName, required String email,
    required String password, required int firstPhoneNumber,
    required String description,var secondPhoneNumber,}) :
        super(userName: userName, email: email,
        password: password, firstPhoneNumber: firstPhoneNumber,
        description: description, secondPhoneNumber:secondPhoneNumber);
  factory NurseModel.fromJson(Map<String, dynamic> json){
    return NurseModel(userName: json['userName']?? '',
        email: json['email']?? '', password: json['password']?? '',
        firstPhoneNumber: json['first_phone_number']?? '',
        description: json['description']?? '',
        secondPhoneNumber: json['second_phone_number']?? '');
  }

  Map<String, dynamic> toJson(){
    return {'password': password, 'email': email, 'userName':userName,
      'first_phone_number': firstPhoneNumber, 'description': description,
      'second_phone_number':secondPhoneNumber};
  }
}