// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_activity_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AddActivityRMToJson(AddActivityRM instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('date', instance.date);
  val['typeName'] = instance.logType;
  writeNotNull('contactId', instance.contactId);
  writeNotNull('companyId', instance.companyName);
  writeNotNull('deal', instance.dealName);
  writeNotNull('task_id', instance.taskId);
  return val;
}
