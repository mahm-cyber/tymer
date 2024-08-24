// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_account_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UpdateAccountRMToJson(UpdateAccountRM instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('account_name', instance.accountName);
  writeNotNull('billing_first_name', instance.companyName);
  writeNotNull('billing_address_1', instance.companyAddress);
  writeNotNull('billing_country', instance.companyCountry);
  return val;
}
