class Settings {
  Settings({
     this.pricing,
    this.termsAndConditions,
    this.privacyPolicy,
    this.faqs,
  });

  final PricingSettings? pricing;
  final PrivacyPolicy? privacyPolicy;
  final TermsAndConditions? termsAndConditions;
  final List<Faq>? faqs;
  Settings copyWith({
    PricingSettings? pricing,
    TermsAndConditions? termsAndConditions,
    PrivacyPolicy? privacyPolicy,
    List<Faq>? faqs,
  }) {
    return Settings(
      pricing: pricing ?? this.pricing,
      termsAndConditions: termsAndConditions?? this.termsAndConditions,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      faqs: faqs ?? this.faqs,
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

class Faq {
  Faq({
    required this.id,
    required this.question,
    required this.answer,
  });

  final int id;
  final String question;
  final String answer;
}
