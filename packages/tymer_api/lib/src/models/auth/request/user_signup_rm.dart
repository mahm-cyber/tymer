import 'package:json_annotation/json_annotation.dart';

part 'user_signup_rm.g.dart';

@JsonSerializable(createFactory: false)
class UserSignUpRM {
  const UserSignUpRM({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phone,
    required this.name,
  });

  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'password_confirmation')
  final String passwordConfirmation;
  @JsonKey(name: 'phone_number')
  final String phone;
  @JsonKey(name: 'name')
  final String name;

  Map<String, dynamic> toJson() => _$UserSignUpRMToJson(this);
}
