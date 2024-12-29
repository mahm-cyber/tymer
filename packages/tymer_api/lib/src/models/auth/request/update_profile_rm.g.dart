// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UpdateProfileUpRMToJson(UpdateProfileUpRM instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.firstName case final value?) 'first_name': value,
      if (instance.lastName case final value?) 'last_name': value,
      if (instance.email case final value?) 'user_email': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.jobTitle case final value?) 'job_title': value,
      if (instance.image case final value?) 'image': value,
    };
