// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_methods_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodsRM _$PaymentMethodsRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymentMethodsRM',
      json,
      ($checkedConvert) {
        final val = PaymentMethodsRM(
          vodafoneCashEnabled:
              $checkedConvert('vodafone_cash_enabled', (v) => v as bool),
          vodafoneCashWalletNumber: $checkedConvert(
              'vodafone_cash_wallet_number', (v) => v as String),
          vodafoneCashMessage: $checkedConvert('vodafone_cash_message',
              (v) => Map<String, String>.from(v as Map)),
          orangeCashEnabled:
              $checkedConvert('orange_cash_enabled', (v) => v as bool),
          orangeCashWalletNumber:
              $checkedConvert('orange_cash_wallet_number', (v) => v as String),
          orangeCashMessage: $checkedConvert(
              'orange_cash_message', (v) => Map<String, String>.from(v as Map)),
          etisalatCashEnabled:
              $checkedConvert('etisalat_cash_enabled', (v) => v as bool),
          etisalatCashWalletNumber: $checkedConvert(
              'etisalat_cash_wallet_number', (v) => v as String),
          etisalatCashMessage: $checkedConvert('etisalat_cash_message',
              (v) => Map<String, String>.from(v as Map)),
          instapayEnabled:
              $checkedConvert('instapay_enabled', (v) => v as bool),
          instapayInstantPaymentAddress: $checkedConvert(
              'instapay_instant_payment_address', (v) => v as String),
          instapayMessage: $checkedConvert(
              'instapay_message', (v) => Map<String, String>.from(v as Map)),
          bankTransferEnabled:
              $checkedConvert('bank_transfer_enabled', (v) => v as bool),
          bankTransferBeneficiaryName: $checkedConvert(
              'bank_transfer_beneficiary_name', (v) => v as String),
          bankTransferBeneficiaryAddress: $checkedConvert(
              'bank_transfer_beneficiary_address', (v) => v as String),
          bankTransferBankName:
              $checkedConvert('bank_transfer_bank_name', (v) => v as String),
          bankTransferBeneficiaryAccountNumber: $checkedConvert(
              'bank_transfer_beneficiary_account_number', (v) => v as String),
          bankTransferIban:
              $checkedConvert('bank_transfer_iban', (v) => v as String),
          bankTransferSwiftCode:
              $checkedConvert('bank_transfer_swift_code', (v) => v as String),
          bankTransferMessage: $checkedConvert('bank_transfer_message',
              (v) => Map<String, String>.from(v as Map)),
        );
        return val;
      },
      fieldKeyMap: const {
        'vodafoneCashEnabled': 'vodafone_cash_enabled',
        'vodafoneCashWalletNumber': 'vodafone_cash_wallet_number',
        'vodafoneCashMessage': 'vodafone_cash_message',
        'orangeCashEnabled': 'orange_cash_enabled',
        'orangeCashWalletNumber': 'orange_cash_wallet_number',
        'orangeCashMessage': 'orange_cash_message',
        'etisalatCashEnabled': 'etisalat_cash_enabled',
        'etisalatCashWalletNumber': 'etisalat_cash_wallet_number',
        'etisalatCashMessage': 'etisalat_cash_message',
        'instapayEnabled': 'instapay_enabled',
        'instapayInstantPaymentAddress': 'instapay_instant_payment_address',
        'instapayMessage': 'instapay_message',
        'bankTransferEnabled': 'bank_transfer_enabled',
        'bankTransferBeneficiaryName': 'bank_transfer_beneficiary_name',
        'bankTransferBeneficiaryAddress': 'bank_transfer_beneficiary_address',
        'bankTransferBankName': 'bank_transfer_bank_name',
        'bankTransferBeneficiaryAccountNumber':
            'bank_transfer_beneficiary_account_number',
        'bankTransferIban': 'bank_transfer_iban',
        'bankTransferSwiftCode': 'bank_transfer_swift_code',
        'bankTransferMessage': 'bank_transfer_message'
      },
    );
