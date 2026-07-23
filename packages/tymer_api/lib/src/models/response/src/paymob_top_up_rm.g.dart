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
          message: $checkedConvert('message', (v) => v as String?),
          data: $checkedConvert(
              'data',
              (v) => v == null
                  ? null
                  : PaymobTopUpDataRM.fromJson(v as Map<String, dynamic>)),
          checkoutUrl: $checkedConvert('checkout_url', (v) => v as String),
          clientSecret: $checkedConvert('client_secret', (v) => v as String?),
          intentionOrderId: $checkedConvert(
              'intention_order_id', (v) => _nullableIntFromJson(v)),
          paymobTransactionId: $checkedConvert(
              'paymob_transaction_id', (v) => _stringFromJson(v)),
          internalTransactionId: $checkedConvert(
              'internal_transaction_id', (v) => _intFromJson(v)),
          topupRequestStatus:
              $checkedConvert('topup_request_status', (v) => v as String?),
          paymobStatus: $checkedConvert(
              'paymob_status',
              (v) => v == null
                  ? null
                  : PaymobStatusRM.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'checkoutUrl': 'checkout_url',
        'clientSecret': 'client_secret',
        'intentionOrderId': 'intention_order_id',
        'paymobTransactionId': 'paymob_transaction_id',
        'internalTransactionId': 'internal_transaction_id',
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
          id: $checkedConvert('id', (v) => _intFromJson(v)),
          amount: $checkedConvert('amount', (v) => _stringFromJson(v)),
          issuer: $checkedConvert('issuer', (v) => v as String?),
          msisdn: $checkedConvert('msisdn', (v) => v as String?),
          status: $checkedConvert('status', (v) => v as String?),
          transactionId:
              $checkedConvert('transaction_id', (v) => _stringFromJson(v)),
        );
        return val;
      },
      fieldKeyMap: const {'transactionId': 'transaction_id'},
    );

PaymobStatusRM _$PaymobStatusRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymobStatusRM',
      json,
      ($checkedConvert) {
        final val = PaymobStatusRM(
          code: $checkedConvert('code', (v) => _nullableIntFromJson(v)),
          status: $checkedConvert('status', (v) => v as String?),
          message: $checkedConvert('message', (v) => v as String?),
        );
        return val;
      },
    );
