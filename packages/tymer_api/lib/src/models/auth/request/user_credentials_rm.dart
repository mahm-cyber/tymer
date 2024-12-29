import 'package:json_annotation/json_annotation.dart';

part 'user_credentials_rm.g.dart';

@JsonSerializable(createFactory: false)
class UserCredentialsRM {
  const UserCredentialsRM({
    required this.phone,
    required this.password,
    required this.pushTokenType,
    required this.pushToken,
    this.remember = true,
  });

  @JsonKey(name: 'phone_number')
  final String phone;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'token_type')
  final String pushTokenType;
  @JsonKey(name: 'token')
  final String pushToken;
  @JsonKey(name: 'remember', defaultValue: true)
  final bool remember;


  Map<String, dynamic> toJson() => _$UserCredentialsRMToJson(this);
}
