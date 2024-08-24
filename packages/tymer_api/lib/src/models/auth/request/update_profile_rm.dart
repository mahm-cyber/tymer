import 'package:json_annotation/json_annotation.dart';

part 'update_profile_rm.g.dart';

@JsonSerializable(createFactory: false)
class UpdateProfileUpRM {
  const UpdateProfileUpRM({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.jobTitle,
    this.image,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'first_name', includeIfNull: false)
  final String? firstName;
  @JsonKey(name: 'last_name', includeIfNull: false)
  final String? lastName;
  @JsonKey(name: 'user_email', includeIfNull: false)
  final String? email;
  @JsonKey(name: 'phone', includeIfNull: false)
  final String? phone;
  @JsonKey(name: 'job_title', includeIfNull: false)
  final String? jobTitle;
  @JsonKey(name: 'image', includeIfNull: false)
  final String? image;

  Map<String, dynamic> toJson() => _$UpdateProfileUpRMToJson(this);
}
