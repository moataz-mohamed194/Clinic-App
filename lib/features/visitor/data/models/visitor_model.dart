import 'package:clinic/features/visitor/%20domain/entities/visitor.dart';

class VisitorModel extends Visitor{
  VisitorModel({required int? id, required String? addedByName,
    required String name, required String reasonOfVisitor, required String? time,
    required bool? approved, required int addedBy}) :
        super(id: id, addedByName: addedByName, name: name,
          reasonOfVisitor: reasonOfVisitor, time: time, approved: approved,
          addedBy: addedBy);

  factory VisitorModel.fromJson(Map<String, dynamic> json){
    return VisitorModel(id: json['id']?? '', addedByName: json['added_by_name']?? '',
        name: json['name']?? '', reasonOfVisitor: json['reason_of_visitor']?? '',
        time: json['time']?? '', approved: json['approved']?? '', addedBy: json['added_by']?? '');
  }

  Map<String, dynamic> toJson(){
    return {'id': id, 'added_by_name': addedByName, 'name':name,
      'reason_of_visitor':reasonOfVisitor, 'time':time, 'approved':approved,
      'added_by':addedBy};
  }
}