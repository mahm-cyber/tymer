class Settings {
  Settings({
     this.pricing,
    this.termsAndConditions,
    this.privacyPolicy,
  });

  final PricingSettings? pricing;
  final PrivacyPolicy? privacyPolicy;
  final TermsAndConditions? termsAndConditions;

  Settings copyWith({
    PricingSettings? pricing,
    TermsAndConditions? termsAndConditions,
    PrivacyPolicy? privacyPolicy,
  }) {
    return Settings(
      pricing: pricing ?? this.pricing,
      termsAndConditions: termsAndConditions?? this.termsAndConditions,
      privacyPolicy: privacyPolicy?? this.privacyPolicy,
    );
  }
}

class PricingSettings {
  PricingSettings({
    required this.reservationServiceMinPrice,
    required this.reservationServiceFee,
    required this.reservationServiceFeeType,
    required this.otherServiceMinPrice,
    required this.otherServiceFee,
    required this.otherServiceFeeType,
  });

  final int reservationServiceMinPrice;
  final int reservationServiceFee;
  final String reservationServiceFeeType;
  final int otherServiceMinPrice;
  final int otherServiceFee;
  final String otherServiceFeeType;
}

class PrivacyPolicy {
  PrivacyPolicy({
    required this.arMarkdown,
    required this.enMarkdown,
  });

  final String arMarkdown;
  final String enMarkdown;
}

class TermsAndConditions {
  TermsAndConditions({
    required this.arMarkdown,
    required this.enMarkdown,
  });

  final String arMarkdown;
  final String enMarkdown;
}
