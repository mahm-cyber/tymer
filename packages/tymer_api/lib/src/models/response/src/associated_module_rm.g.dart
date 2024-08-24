// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'associated_module_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociatedModuleRM _$AssociatedModuleRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AssociatedModuleRM',
      json,
      ($checkedConvert) {
        final val = AssociatedModuleRM(
          termId: $checkedConvert('term_id', (v) => (v as num).toInt()),
          name: $checkedConvert('name', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'termId': 'term_id'},
    );
