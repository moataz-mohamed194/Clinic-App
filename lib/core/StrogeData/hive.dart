import 'package:hive/hive.dart';

part 'hive.g.dart';

@HiveType(typeId: 1)
class Person extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? pk;

  @HiveField(2)
  String? typeOfAccount;

  @HiveField(3)
  bool? logged;

  @HiveField(4)
  String? language;
}
