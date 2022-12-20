import 'package:equatable/equatable.dart';

class Fees extends Equatable{
  final int? id;
  final String type;
  final String price;
  final String time;

  Fees({required this.id, required this.type, required this.price, required this.time});

  @override
  List<Object?> get props => [id, type, price, time];

}