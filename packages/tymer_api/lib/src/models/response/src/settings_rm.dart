import 'package:json_annotation/json_annotation.dart';

part 'settings_rm.g.dart';

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

@JsonSerializable(createToJson: false)
class TermsAndConditionsRM {
  TermsAndConditionsRM({
    required this.arHtml,
    required this.enHtml,
  });

  @JsonKey(name: 'ar')
  final String arHtml;
  @JsonKey(name: 'en')
  final String enHtml;

  static const fromJson = _$TermsAndConditionsRMFromJson;
}

@JsonSerializable(createToJson: false)
class PrivacyPolicyRM {
  PrivacyPolicyRM({
    required this.arHtml,
    required this.enHtml,
  });
  @JsonKey(name: 'ar')
  final String arHtml;
  @JsonKey(name: 'en')
  final String enHtml;

  static const fromJson = _$PrivacyPolicyRMFromJson;
}

@JsonSerializable(createToJson: false)
class FaqRM {
  FaqRM({
    required this.id,
    required this.localizedQuestion,
    required this.localizedAnswer,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'question')
  final Map<String, String> localizedQuestion;
  @JsonKey(name: 'answer')
  final Map<String, String> localizedAnswer;

  static const fromJson = _$FaqRMFromJson;
}
