import '../../ domain/entities/Fees.dart';

class FeesModel extends Fees{
  FeesModel({required int? id,
    required String type,
    required String price,
    required String time}) :
        super(id: id,
          type: type,
          price: price,
          time: time);
  factory FeesModel.fromJson(Map<String, dynamic> json){
    return FeesModel(id: json['id']?? '', type: json['type']?? '',
        price: json['price']?? '', time: json['time']?? '');
  }

  Map<String, dynamic> toJson(){
    return {'id': id,
      'type': type,
      'time':time,
      'price':price};
  }
}