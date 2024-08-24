import 'package:hive/hive.dart';

part 'deal_stage_cm.g.dart';

@HiveType(typeId: 11)
class DealStageCM {
  const DealStageCM({
    required this.id,
    required this.name,
    required this.color,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String color;
}
