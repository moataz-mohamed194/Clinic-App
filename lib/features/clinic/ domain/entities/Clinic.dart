import 'package:equatable/equatable.dart';

class Clinic extends Equatable{
  final int? id;
  final String addrees;
  final String note;
  final String fromTime;
  final String toTime;
  final String timeOfVacation;
  final String? latitude;
  final String? longitude;

  Clinic(
      {required this.id,
       required this.addrees,
       required this.note,
       required this.fromTime,
       required this.toTime,
        required this.latitude,
        required this.longitude,
       required this.timeOfVacation});
  @override
  List<Object?> get props => [id, addrees, note, fromTime, toTime, timeOfVacation];

}