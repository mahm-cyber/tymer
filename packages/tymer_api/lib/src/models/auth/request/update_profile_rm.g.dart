// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UpdateProfileUpRMToJson(UpdateProfileUpRM instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('user_email', instance.email);
  writeNotNull('phone', instance.phone);
  writeNotNull('job_title', instance.jobTitle);
  writeNotNull('image', instance.image);
  return val;
}
