// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_account_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UpdateAccountRMToJson(UpdateAccountRM instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.accountName case final value?) 'account_name': value,
      if (instance.companyName case final value?) 'billing_first_name': value,
      if (instance.companyAddress case final value?) 'billing_address_1': value,
      if (instance.companyCountry case final value?) 'billing_country': value,
    };
