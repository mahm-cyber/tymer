import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension UserCMtoDM on UserCM {
  User toDomainModel() {
    return User(
      id: id,
      name: name,
      email: email,
      jobTitle: jobTitle,
      phone: phone,
      companyName: companyName,
      companyAddress: companyAddress,
      companyCountry: companyCountry,
      accountName: accountName,
      companyDomain: companyDomain,

    );
  }
}



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
