import 'package:hive/hive.dart';
import 'package:key_value_storage/src/models/app_dependencies/src/custom_field_type_cm.dart';

part 'custom_field_cm.g.dart';

@HiveType(typeId: 14)
class CustomFieldCM {
  const CustomFieldCM({
    required this.id,
    required this.label,
    required this.name,
    required this.type,
    required this.choices,
    required this.isRequired,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String label;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final CustomFieldTypeCM type;
  @HiveField(4)
  final List<String> choices;
  @HiveField(5)
  final bool isRequired;
}
