import 'package:tymer_api/tymer_api.dart';
import 'package:domain_models/domain_models.dart';

extension UserRMtoDM on UserRM {
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
      accountName: sites?.first.accountName,
      companyDomain: sites?.first.companyDomain,
    );
  }
}

