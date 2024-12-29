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
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String),
          emailVerifiedAt:
              $checkedConvert('email_verified_at', (v) => v as String?),
          phone: $checkedConvert('phone_number', (v) => v as String),
          phoneVerifiedAt:
              $checkedConvert('phone_number_verified_at', (v) => v as String?),
          permissions:
              $checkedConvert('permissions', (v) => v as List<dynamic>),
          roles: $checkedConvert('roles', (v) => v as List<dynamic>),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          language: $checkedConvert('preferred_language', (v) => v as String),
          updatedAt: $checkedConvert('updated_at', (v) => v as String?),
          deletedAt: $checkedConvert('deleted_at', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'emailVerifiedAt': 'email_verified_at',
        'phone': 'phone_number',
        'phoneVerifiedAt': 'phone_number_verified_at',
        'createdAt': 'created_at',
        'language': 'preferred_language',
        'updatedAt': 'updated_at',
        'deletedAt': 'deleted_at'
      },
    );
