import 'package:json_annotation/json_annotation.dart';

part 'update_account_rm.g.dart';

@JsonSerializable(createFactory: false)
class UpdateAccountRM {
  const UpdateAccountRM({
    required this.id,
    this.accountName,
    this.companyName,
    this.companyAddress,
    this.companyCountry,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'account_name', includeIfNull: false)
  final String? accountName;
  @JsonKey(name: 'billing_first_name', includeIfNull: false)
  final String? companyName;
  @JsonKey(name: 'billing_address_1', includeIfNull: false)
  final String? companyAddress;
  @JsonKey(name: 'billing_country', includeIfNull: false)
  final String? companyCountry;

  Map<String, dynamic> toJson() => _$UpdateAccountRMToJson(this);
}
