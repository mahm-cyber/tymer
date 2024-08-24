import 'package:hive/hive.dart';
import 'package:key_value_storage/src/models/app_dependencies/src/user_cm.dart';

part 'app_users_cm.g.dart';

@HiveType(typeId: 6)
class AppUsersCM {
  const AppUsersCM({
    required this.list,
  });

  @HiveField(0)
  final List<UserCM> list;
}
