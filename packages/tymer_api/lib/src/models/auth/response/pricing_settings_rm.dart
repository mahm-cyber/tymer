import 'package:json_annotation/json_annotation.dart';

part 'pricing_settings_rm.g.dart';

@JsonSerializable(createToJson: false)
class PricingSettingsRM {
  PricingSettingsRM({
    required this.reservationServiceMinPrice,
    required this.reservationServiceFee,
    required this.reservationServiceFeeType,
    required this.otherServiceMinPrice,
    required this.otherServiceFee,
    required this.otherServiceFeeType,
  });

  @JsonKey(name: 'reservation_service_min_price')
  final int reservationServiceMinPrice;
  @JsonKey(name: 'reservation_service_fee')
  final int reservationServiceFee;
  @JsonKey(name: 'reservation_service_fee_type')
  final String reservationServiceFeeType;
  @JsonKey(name: 'other_service_min_price')
  final int otherServiceMinPrice;
  @JsonKey(name: 'other_service_fee')
  final int otherServiceFee;
  @JsonKey(name: 'other_service_fee_type')
  final String otherServiceFeeType;

  static const fromJson = _$PricingSettingsRMFromJson;
}