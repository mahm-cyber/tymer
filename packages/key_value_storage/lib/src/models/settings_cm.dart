import 'package:hive/hive.dart';

part 'settings_cm.g.dart';

@HiveType(typeId: 8)
class SettingsCM {
  SettingsCM({
     this.pricing,
    this.termsAndConditions,
    this.privacyPolicy,
  });

  @HiveField(0)
  final PricingSettingsCM? pricing;
  @HiveField(1)
  final TermsAndConditionsCM? termsAndConditions;
  @HiveField(2)
  final PrivacyPolicyCM? privacyPolicy;

  SettingsCM copyWith({
    PricingSettingsCM? pricing,
    TermsAndConditionsCM? termsAndConditions,
    PrivacyPolicyCM? privacyPolicy,
  }) {
    return SettingsCM(
      pricing: pricing ?? this.pricing,
      termsAndConditions: termsAndConditions?? this.termsAndConditions,
      privacyPolicy: privacyPolicy?? this.privacyPolicy,
    );
  }
}

@HiveType(typeId: 5)
class PricingSettingsCM {
  PricingSettingsCM({
    required this.reservationServiceMinPrice,
    required this.reservationServiceFee,
    required this.reservationServiceFeeType,
    required this.otherServiceMinPrice,
    required this.otherServiceFee,
    required this.otherServiceFeeType,
  });

  @HiveField(0)
  final int reservationServiceMinPrice;
  @HiveField(1)
  final int reservationServiceFee;
  @HiveField(2)
  final String reservationServiceFeeType;
  @HiveField(3)
  final int otherServiceMinPrice;
  @HiveField(4)
  final int otherServiceFee;
  @HiveField(5)
  final String otherServiceFeeType;
}

@HiveType(typeId: 6)
class TermsAndConditionsCM {
  TermsAndConditionsCM({
    required this.arHtml,
    required this.enHtml,
  });

  @HiveField(0)
  final String arHtml;
  @HiveField(1)
  final String enHtml;
}

@HiveType(typeId: 7)
class PrivacyPolicyCM {
  PrivacyPolicyCM({
    required this.arHtml,
    required this.enHtml,
  });

  @HiveField(0)
  final String arHtml;
  @HiveField(1)
  final String enHtml;
}
