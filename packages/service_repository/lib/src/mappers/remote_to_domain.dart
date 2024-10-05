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
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,


    );
  }
}

