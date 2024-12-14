// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_settings_rm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricingSettingsRM _$PricingSettingsRMFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PricingSettingsRM',
      json,
      ($checkedConvert) {
        final val = PricingSettingsRM(
          reservationServiceMinPrice: $checkedConvert(
              'reservation_service_min_price', (v) => (v as num).toInt()),
          reservationServiceFee: $checkedConvert(
              'reservation_service_fee', (v) => (v as num).toInt()),
          reservationServiceFeeType: $checkedConvert(
              'reservation_service_fee_type', (v) => v as String),
          otherServiceMinPrice: $checkedConvert(
              'other_service_min_price', (v) => (v as num).toInt()),
          otherServiceFee:
              $checkedConvert('other_service_fee', (v) => (v as num).toInt()),
          otherServiceFeeType:
              $checkedConvert('other_service_fee_type', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'reservationServiceMinPrice': 'reservation_service_min_price',
        'reservationServiceFee': 'reservation_service_fee',
        'reservationServiceFeeType': 'reservation_service_fee_type',
        'otherServiceMinPrice': 'other_service_min_price',
        'otherServiceFee': 'other_service_fee',
        'otherServiceFeeType': 'other_service_fee_type'
      },
    );
