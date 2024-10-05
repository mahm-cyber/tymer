import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension LocalePreferenceCMToDomain on LocalePreferenceCM {
  LocalePreferenceDM toDomainModel() {
    switch (this) {
      case LocalePreferenceCM.english:
        return LocalePreferenceDM.english;
      case LocalePreferenceCM.arabic:
        return LocalePreferenceDM.arabic;
    }
  }
}

extension ReservationServiceTypeCMtoDM on ReservationServiceTypeCM {
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

extension ReservationServiceTypesCMtoDM on ReservationServiceTypesCM {
  List<ReservationServiceType> toDomainModel() {
    return list.map((e) => e.toDomainModel()).toList();
  }
}
