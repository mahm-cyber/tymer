import 'package:json_annotation/json_annotation.dart';

part 'user_rm.g.dart';

@JsonSerializable(createToJson: false)
class UserRM {
  UserRM({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.phone,
    this.phoneVerifiedAt,
    required this.permissions,
    required this.roles,
    required this.createdAt,
    required this.language,
    this.updatedAt,
    this.deletedAt,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'email_verified_at')
  final String? emailVerifiedAt;
  @JsonKey(name: 'phone_number')
  final String phone;
  @JsonKey(name: 'phone_number_verified_at')
  final String? phoneVerifiedAt;
  @JsonKey(name: 'permissions')
  final List permissions;
  @JsonKey(name: 'roles')
  final List roles;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'preferred_language')
  final String language;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  static const fromJson = _$UserRMFromJson;
}
