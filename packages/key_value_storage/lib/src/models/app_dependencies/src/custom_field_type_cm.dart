import 'package:hive/hive.dart';

part 'custom_field_type_cm.g.dart';

@HiveType(typeId: 15)
enum CustomFieldTypeCM {
  @HiveField(2)
  text,
  @HiveField(3)
  textarea,
  @HiveField(4)
  number,
  @HiveField(5)
  date,
  @HiveField(6)
  dateTime,
  @HiveField(7)
  email,
  @HiveField(8)
  tel,
  @HiveField(9)
  select,
  @HiveField(10)
  multiselect,
  @HiveField(11)
  contacts,
  @HiveField(12)
  companies,
  @HiveField(13)
  deals,
  @HiveField(14)
  checkbox,
  @HiveField(15)
  radio,
}
