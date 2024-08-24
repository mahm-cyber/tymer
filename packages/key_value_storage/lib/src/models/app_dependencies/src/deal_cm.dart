import 'package:hive/hive.dart';

part 'deal_cm.g.dart';

@HiveType(typeId: 9)
class DealCM {
  const DealCM({
    required this.id,
    required this.name,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

}
