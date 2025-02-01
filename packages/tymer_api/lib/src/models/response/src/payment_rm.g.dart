// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentRM _$PaymentRMFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PaymentRM',
      json,
      ($checkedConvert) {
        final val = PaymentRM(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          userId: $checkedConvert('user_id', (v) => (v as num).toInt()),
          amount: $checkedConvert('amount', (v) => v as String),
          ibanNumber: $checkedConvert('iban_number', (v) => v as String?),
          beneficiaryName:
              $checkedConvert('beneficiary_name', (v) => v as String?),
          instantPaymentAddress:
              $checkedConvert('instant_payment_address', (v) => v as String?),
          walletNumber: $checkedConvert('wallet_number', (v) => v as String?),
          status: $checkedConvert('status', (v) => v as String),
          proofImage: $checkedConvert('proof_image', (v) => v as String?),
          updatedAt: $checkedConvert('updated_at', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'userId': 'user_id',
        'ibanNumber': 'iban_number',
        'beneficiaryName': 'beneficiary_name',
        'instantPaymentAddress': 'instant_payment_address',
        'walletNumber': 'wallet_number',
        'proofImage': 'proof_image',
        'updatedAt': 'updated_at'
      },
    );

PaymentListPageRM _$PaymentListPageRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymentListPageRM',
      json,
      ($checkedConvert) {
        final val = PaymentListPageRM(
          list: $checkedConvert(
              'data',
              (v) => (v as List<dynamic>)
                  .map((e) => PaymentRM.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'list': 'data'},
    );
