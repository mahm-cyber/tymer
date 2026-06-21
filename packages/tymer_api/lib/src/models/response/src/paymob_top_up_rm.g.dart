// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymob_top_up_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymobTopUpRM _$PaymobTopUpRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymobTopUpRM',
      json,
      ($checkedConvert) {
        final val = PaymobTopUpRM(
          success: $checkedConvert('success', (v) => v as bool),
          message: $checkedConvert('message', (v) => v as String),
          data: $checkedConvert('data',
              (v) => PaymobTopUpDataRM.fromJson(v as Map<String, dynamic>)),
          topupRequestStatus:
              $checkedConvert('topup_request_status', (v) => v as String),
          paymobStatus: $checkedConvert('paymob_status',
              (v) => PaymobStatusRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'topupRequestStatus': 'topup_request_status',
        'paymobStatus': 'paymob_status'
      },
    );

PaymobTopUpDataRM _$PaymobTopUpDataRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymobTopUpDataRM',
      json,
      ($checkedConvert) {
        final val = PaymobTopUpDataRM(
          transactionId:
              $checkedConvert('transaction_id', (v) => (v as num).toInt()),
          amount: $checkedConvert('amount', (v) => v as String),
          issuer: $checkedConvert('issuer', (v) => v as String),
          msisdn: $checkedConvert('msisdn', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          checkoutUrl: $checkedConvert('checkout_url', (v) => v as String),
          clientSecret: $checkedConvert('client_secret', (v) => v as String),
          intentionOrderId:
              $checkedConvert('intention_order_id', (v) => (v as num).toInt()),
          paymobTransactionId:
              $checkedConvert('paymob_transaction_id', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'transactionId': 'transaction_id',
        'checkoutUrl': 'checkout_url',
        'clientSecret': 'client_secret',
        'intentionOrderId': 'intention_order_id',
        'paymobTransactionId': 'paymob_transaction_id'
      },
    );

PaymobStatusRM _$PaymobStatusRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymobStatusRM',
      json,
      ($checkedConvert) {
        final val = PaymobStatusRM(
          code: $checkedConvert('code', (v) => (v as num).toInt()),
          status: $checkedConvert('status', (v) => v as String),
          message: $checkedConvert('message', (v) => v as String),
        );
        return val;
      },
    );
