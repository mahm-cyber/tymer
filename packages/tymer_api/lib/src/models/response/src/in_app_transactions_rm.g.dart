// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_app_transactions_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InAppTransactionRM _$InAppTransactionRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'InAppTransactionRM',
      json,
      ($checkedConvert) {
        final val = InAppTransactionRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          userId: $checkedConvert('user_id', (v) => (v as num).toInt()),
          type: $checkedConvert('type', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          amount: $checkedConvert('amount', (v) => v as String),
          createdAt: $checkedConvert('created_at', (v) => v as String),
          updatedAt: $checkedConvert('updated_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'userId': 'user_id',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at'
      },
    );

InAppTransactionListPageRM _$InAppTransactionListPageRMFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'InAppTransactionListPageRM',
      json,
      ($checkedConvert) {
        final val = InAppTransactionListPageRM(
          list: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) =>
                      InAppTransactionRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'list': 'data'},
    );
