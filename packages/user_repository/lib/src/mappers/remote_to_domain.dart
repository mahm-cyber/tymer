import 'package:tymer_api/tymer_api.dart';
import 'package:domain_models/domain_models.dart';

extension UserRMtoDM on UserRM {
  User toDomainModel() {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      emailVerifiedAt: emailVerifiedAt,
      phoneVerifiedAt: phoneVerifiedAt,
      permissions: permissions,
      roles: roles,
    );
  }
}

extension ReservationServiceTypeRMtoDM on ReservationServiceTypeRM {
  ReservationServiceType toDomainModel() {
    return ReservationServiceType(
      id: id,
      name: Name(
        ar: name.ar,
        en: name.en,
      ),
    );
  }
}

extension ReservationServiceTypesRMtoDM on ReservationServiceTypesRM {
  List<ReservationServiceType> toDomainModel() {
    return list.map((e) => e.toDomainModel()).toList();
  }
}

extension PricingSettingsRMtoDM on PricingSettingsRM {
  PricingSettings toDomainModel() {
    return PricingSettings(
      reservationServiceMinPrice: reservationServiceMinPrice,
      reservationServiceFee: reservationServiceFee,
      reservationServiceFeeType: reservationServiceFeeType,
      otherServiceMinPrice: otherServiceMinPrice,
      otherServiceFee: otherServiceFee,
      otherServiceFeeType: otherServiceFeeType,
    );
  }
}

extension PrivacyPolicyRMtoDM on PrivacyPolicyRM {
  PrivacyPolicy toDomainModel() {
    return PrivacyPolicy(
      arMarkdown: arHtml,
      enMarkdown: enHtml,
    );
  }
}

extension TermsAndConditionsRMtoDM on TermsAndConditionsRM {
  TermsAndConditions toDomainModel() {
    return TermsAndConditions(
      arMarkdown: arHtml,
      enMarkdown: enHtml,
    );
  }
}