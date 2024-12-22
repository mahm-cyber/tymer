//
//
import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';


extension LocalePreferenceDomainToCM on LocalePreferenceDM {
  LocalePreferenceCM toCacheModel() {
    switch (this) {
      case LocalePreferenceDM.english:
        return LocalePreferenceCM.english;
      case LocalePreferenceDM.arabic:
        return LocalePreferenceCM.arabic;
    }
  }
}
