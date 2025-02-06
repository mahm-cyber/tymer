import 'package:key_value_storage/key_value_storage.dart';
import 'package:tymer_api/tymer_api.dart';

extension ReservationServiceTypeRMtoCM on ReservationServiceTypeRM {
  ReservationServiceTypeCM toCacheModel() {
    return ReservationServiceTypeCM(
      id: id,
      name: NameCM(
        ar: name.ar,
        en: name.en,
      ),
    );
  }
}

extension ReservationServiceTypesRMtoCM on ReservationServiceTypesRM {
  ReservationServiceTypesCM toCacheModel() {
    return ReservationServiceTypesCM(
      list: list.map((e) => e.toCacheModel()).toList(),
    );
  }
}

extension PricingSettingsRMtoCM on PricingSettingsRM {
  PricingSettingsCM toCacheModel() {
    return PricingSettingsCM(
      reservationServiceMinPrice: reservationServiceMinPrice,
      reservationServiceFee: reservationServiceFee,
      reservationServiceFeeType: reservationServiceFeeType,
      otherServiceMinPrice: otherServiceMinPrice,
      otherServiceFee: otherServiceFee,
      otherServiceFeeType: otherServiceFeeType,
    );
  }
}

extension TermsAndConditionsRMtoCM on TermsAndConditionsRM {
  TermsAndConditionsCM toCacheModel() {
    return TermsAndConditionsCM(
      arHtml: arHtml,
      enHtml: enHtml,
    );
  }
}

extension PrivacyPolicyRMtoCM on PrivacyPolicyRM {
  PrivacyPolicyCM toCacheModel() {
    return PrivacyPolicyCM(
      arHtml: arHtml,
      enHtml: enHtml,
    );
  }
}

extension FaqRMtoCM on FaqRM {
  FaqCM toCacheModel() {
    return FaqCM(
      id: id,
      question: localizedQuestion,
      answer: localizedAnswer,
    );
  }
}

extension FaqsRMtoCM on List<FaqRM> {
  FaqsCM toCacheModel() {
    return FaqsCM(
      list: map((e) => e.toCacheModel()).toList(),
    );
  }
}
