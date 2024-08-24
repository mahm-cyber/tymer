// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRM _$UserRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UserRM',
      json,
      ($checkedConvert) {
        final val = UserRM(
          id: $checkedConvert('id', (v) => v),
          name: $checkedConvert('name', (v) => v as String?),
          lastName: $checkedConvert('last_name', (v) => v as String?),
          sites: $checkedConvert(
              'sites',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => SiteRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
          type: $checkedConvert('role', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
          jobTitle: $checkedConvert('jobTitle', (v) => v as String?),
          phone: $checkedConvert('phone', (v) => v as String?),
          companyName: $checkedConvert('company_name', (v) => v as String?),
          companyAddress:
              $checkedConvert('company_address', (v) => v as String?),
          companyCountry:
              $checkedConvert('company_country', (v) => v as String?),
          token: $checkedConvert('auth', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'lastName': 'last_name',
        'type': 'role',
        'companyName': 'company_name',
        'companyAddress': 'company_address',
        'companyCountry': 'company_country',
        'token': 'auth'
      },
    );

SiteRM _$SiteRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SiteRM',
      json,
      ($checkedConvert) {
        final val = SiteRM(
          id: $checkedConvert('userblog_id', (v) => (v as num).toInt()),
          path: $checkedConvert('path', (v) => v as String),
          accountName: $checkedConvert('blogname', (v) => v as String?),
          companyDomain: $checkedConvert('siteurl', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'userblog_id',
        'accountName': 'blogname',
        'companyDomain': 'siteurl'
      },
    );
