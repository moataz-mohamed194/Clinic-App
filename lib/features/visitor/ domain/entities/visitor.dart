import 'package:equatable/equatable.dart';

class Visitor extends Equatable{
  final int? id;
  final String? addedByName;
  final String name;
  final String reasonOfVisitor;
  final String? time;
  final bool? approved;
  final int addedBy;

  Visitor({required this.id,required  this.addedByName,required  this.name,
    required this.reasonOfVisitor,required this.time,required  this.approved,
    required this.addedBy});

  @override
  List<Object?> get props => [id, addedByName, name, reasonOfVisitor, time,
    approved, addedBy];

}