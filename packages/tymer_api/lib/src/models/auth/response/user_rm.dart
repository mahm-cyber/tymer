import 'package:json_annotation/json_annotation.dart';

part 'user_rm.g.dart';

@JsonSerializable(createToJson: false)
class UserRM {
  UserRM({
    required this.id,
    this.name,
    this.lastName,
    this.sites,
    this.type,
    this.email,
    this.jobTitle,
    this.phone,
    this.companyName,
    this.companyAddress,
    this.companyCountry,
    this.token,
  });

  @JsonKey(name: 'id')
  final dynamic id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'sites')
  final List<SiteRM>? sites;
  @JsonKey(name: 'role')
  final String? type;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'jobTitle')
  final String? jobTitle;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'company_name')
  final String? companyName;
  @JsonKey(name: 'company_address')
  final String? companyAddress;
  @JsonKey(name: 'company_country')
  final String? companyCountry;
  @JsonKey(name: 'auth')
  final String? token;

  static const fromJson = _$UserRMFromJson;
}

@JsonSerializable(createToJson: false)
class SiteRM {
  SiteRM({
    required this.id,
    required this.path,
    this.accountName,
    this.companyDomain,
  });

  @JsonKey(name: 'userblog_id')
  final int id;
  @JsonKey(name: 'path')
  final String path;
  @JsonKey(name: 'blogname')
  final String? accountName;
  @JsonKey(name: 'siteurl')
  final String? companyDomain;

  static const fromJson = _$SiteRMFromJson;
}
