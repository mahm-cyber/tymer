import 'package:hive/hive.dart';

import 'task_cm.dart';

part 'app_tasks_cm.g.dart';

@HiveType(typeId: 5)
class AppTasksCM {
  const AppTasksCM({
    required this.list,

  });


  @HiveField(1)
  final List<TaskCM> list;


}
