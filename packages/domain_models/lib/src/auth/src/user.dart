import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? emailVerifiedAt;
  final String? phoneVerifiedAt;
  final List? permissions;
  final List? roles;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.permissions,
    this.roles,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        emailVerifiedAt,
        phoneVerifiedAt,
        permissions,
        roles,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}
