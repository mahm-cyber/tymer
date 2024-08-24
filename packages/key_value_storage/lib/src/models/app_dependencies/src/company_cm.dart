import 'package:hive/hive.dart';

part 'company_cm.g.dart';

@HiveType(typeId: 7)
class CompanyCM {
  const CompanyCM({
    required this.id,
    required this.name,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

}
