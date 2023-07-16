import '../../ domain/entities/sick.dart';

class SickModel extends Sick {
  SickModel(
      {String? addByName,
      String? doctorReport,
      bool? approved,
      String? time,
      int? approvedBy,
      required int? id,
      required String name,
      required int phoneNumber,
      int? pk,
      required String typeOfStatment})
      : super(
            addByName: addByName,
            doctorReport: doctorReport,
            approved: approved,
            time: time,
            approvedBy: approvedBy,
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            typeOfStatment: typeOfStatment,
            pk: pk);
  factory SickModel.fromJson(Map<String, dynamic> json) {
    return SickModel(
        id: json['id'] ?? '',
        phoneNumber: json['phone_number'] ?? '',
        name: json['name'] ?? '',
        pk: json['added_by'] ?? '',
        typeOfStatment: json['type_of_statement'],
        addByName: json['added_by_name'],
        doctorReport: json['doctor_report'],
        approved: json['approved'],
        time: json['time'],
        approvedBy: json['approved_by']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone_number': phoneNumber,
      'name': name,
      'type_of_statement': typeOfStatment,
      'added_by': pk,
      'approved_by': approvedBy,
      'time': time,
      'approved': approved,
      'doctor_report': doctorReport,
      'added_by_name': addByName
    };
  }
}
