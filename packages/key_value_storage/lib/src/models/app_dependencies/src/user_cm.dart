import 'package:hive/hive.dart';

part 'user_cm.g.dart';

@HiveType(typeId: 13)
class UserCM {
  const UserCM({
    required this.id,
    required this.name,
    this.email,
    this.jobTitle,
    this.phone,
    this.companyName,
    this.companyAddress,
    this.companyCountry,
    this.accountName,
    this.companyDomain,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? jobTitle;
  @HiveField(4)
  final String? phone;
  @HiveField(5)
  final String? companyName;
  @HiveField(6)
  final String? companyAddress;
  @HiveField(7)
  final String? companyCountry;
  @HiveField(8)
  final String? accountName;
  @HiveField(9)
  final String? companyDomain;
}
