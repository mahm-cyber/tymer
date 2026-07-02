// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymob_sync_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymobSyncRM _$PaymobSyncRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymobSyncRM',
      json,
      ($checkedConvert) {
        final val = PaymobSyncRM(
          success: $checkedConvert('success', (v) => v as bool),
          message: $checkedConvert('message', (v) => v as String),
          data: $checkedConvert('data',
              (v) => PaymobSyncDataRM.fromJson(v as Map<String, dynamic>)),
          paymobStatus: $checkedConvert('paymob_status',
              (v) => PaymobSyncStatusRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'paymobStatus': 'paymob_status'},
    );

PaymobSyncDataRM _$PaymobSyncDataRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymobSyncDataRM',
      json,
      ($checkedConvert) {
        final val = PaymobSyncDataRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          status: $checkedConvert('status', (v) => v as String),
          isSuccess: $checkedConvert('is_success', (v) => v as bool),
          amount: $checkedConvert('amount', (v) => v as String),
          issuer: $checkedConvert('issuer', (v) => v as String),
          msisdn: $checkedConvert('msisdn', (v) => v as String),
          transactionId: $checkedConvert('transaction_id', (v) => v as String),
          intentionOrderId:
              $checkedConvert('intention_order_id', (v) => v as String),
          isCompleted: $checkedConvert('is_completed', (v) => v as bool),
          isFailed: $checkedConvert('is_failed', (v) => v as bool),
          isPending: $checkedConvert('is_pending', (v) => v as bool),
          message: $checkedConvert('message', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'isSuccess': 'is_success',
        'transactionId': 'transaction_id',
        'intentionOrderId': 'intention_order_id',
        'isCompleted': 'is_completed',
        'isFailed': 'is_failed',
        'isPending': 'is_pending'
      },
    );

PaymobSyncStatusRM _$PaymobSyncStatusRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymobSyncStatusRM',
      json,
      ($checkedConvert) {
        final val = PaymobSyncStatusRM(
          success: $checkedConvert('success', (v) => v as bool),
          status: $checkedConvert('status', (v) => v as String),
          paymobStatus: $checkedConvert('paymob_status', (v) => v as String),
          isSuccess: $checkedConvert('is_success', (v) => v as bool),
          note: $checkedConvert('note', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'paymobStatus': 'paymob_status',
        'isSuccess': 'is_success'
      },
    );
