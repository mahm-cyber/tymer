// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionRM _$TransactionRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TransactionRM',
      json,
      ($checkedConvert) {
        final val = TransactionRM(
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

TransactionListPageRM _$TransactionListPageRMFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'TransactionListPageRM',
      json,
      ($checkedConvert) {
        final val = TransactionListPageRM(
          list: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) => TransactionRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'list': 'data'},
    );
