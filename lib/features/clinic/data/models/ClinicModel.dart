import 'package:clinic/features/clinic/%20domain/entities/Clinic.dart';

class ClinicModel extends Clinic{
  ClinicModel({required String addrees,
    required String note,
    required String fromTime,
    required String toTime,
    required String timeOfVacation,
    required int? id}) :
        super(addrees: addrees,
          note: note,
          fromTime: fromTime,
          toTime: toTime,
          id: id,
          timeOfVacation: timeOfVacation);
  factory ClinicModel.fromJson(Map<String, dynamic> json){
    return ClinicModel(id: json['id']?? '', note: json['note']?? '',
        addrees: json['address']?? '', fromTime: json['from_time']?? '',
        toTime: json['to_time']?? '', timeOfVacation: json['time_of_vacation']?? '');
  }

  Map<String, dynamic> toJson(){
    return {'id': id, 'to_time': toTime, 'time_of_vacation':timeOfVacation,
      'from_time':fromTime, 'note':note, 'addrees':addrees};
  }
}