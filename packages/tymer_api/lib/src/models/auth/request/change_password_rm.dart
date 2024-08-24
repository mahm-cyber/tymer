import 'package:json_annotation/json_annotation.dart';

part 'change_password_rm.g.dart';

@JsonSerializable(createFactory: false)
class ChangePasswordRM {
  const ChangePasswordRM({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
  });

  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'token')
  final String oldPassword;
  @JsonKey(name: 'password')
  final String newPassword;

  Map<String, dynamic> toJson() => _$ChangePasswordRMToJson(this);
}
