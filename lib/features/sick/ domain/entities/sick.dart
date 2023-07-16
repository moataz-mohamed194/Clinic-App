import 'package:equatable/equatable.dart';

class Sick extends Equatable {
  final int? id;
  final String name;
  final int phoneNumber;
  final String typeOfStatment;
  final int? pk;
  final String? addByName;
  final String? doctorReport;
  final bool? approved;
  final String? time;
  final int? approvedBy;

  Sick(
      {this.addByName,
      this.doctorReport,
      this.approved,
      this.time,
      this.approvedBy,
      required this.id,
      required this.name,
      required this.phoneNumber,
      required this.typeOfStatment,
      this.pk});

  @override
  List<Object?> get props => [
        name,
        phoneNumber,
        pk,
        typeOfStatment,
        addByName,
        doctorReport,
        approved,
        time,
        approvedBy
      ];
}
