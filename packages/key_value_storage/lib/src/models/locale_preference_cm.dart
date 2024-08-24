import 'package:hive/hive.dart';

part 'locale_preference_cm.g.dart';

@HiveType(typeId: 23)
enum LocalePreferenceCM {
  @HiveField(0)
  english,
  @HiveField(1)
  arabic,
}
