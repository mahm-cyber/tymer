import 'package:hive/hive.dart';

part 'task_cm.g.dart';

@HiveType(typeId: 12)
class TaskCM {
  const TaskCM({
    required this.id,
    required this.name,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
}
