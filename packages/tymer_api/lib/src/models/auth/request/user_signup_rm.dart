import 'package:json_annotation/json_annotation.dart';

part 'user_signup_rm.g.dart';

@JsonSerializable(createFactory: false)
class UserSignUpRM {
  const UserSignUpRM({
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
    required this.city,
    required this.birthdate,
    this.fcmToken = '',
    required this.gender,
  });

  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'username')
  final String name;
  @JsonKey(name: 'city')
  final String city;
  @JsonKey(name: 'birthDate')
  final String birthdate;
  @JsonKey(name: 'mktoken')
  final String fcmToken;
  @JsonKey(name: 'gender')
  final String gender;

  Map<String, dynamic> toJson() => _$UserSignUpRMToJson(this);
}
