import 'package:hive/hive.dart';

part 'life_cycles_cm.g.dart';

@HiveType(typeId: 16)
class LifeCyclesCM {
  const LifeCyclesCM({
    this.contact = const [],
    this.company = const [],
    this.deal = const [],
  });

  @HiveField(0)
  final List<String> contact;
  @HiveField(1)
  final List<String> company;
  @HiveField(2)
  final List<String> deal;
}
