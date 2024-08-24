import 'package:hive/hive.dart';

part 'contact_cm.g.dart';

@HiveType(typeId: 8)
class ContactCM {
  const ContactCM({
    required this.id,
    required this.name,
    this.lastName,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? lastName;

}
