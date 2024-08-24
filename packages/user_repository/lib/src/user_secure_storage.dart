import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _userIdKey = 'user-id';
  static const _userNameKey = 'user-name';
  static const _userLastNameKey = 'user-last-name';
  static const _userSlugKey = 'user-slug';
  static const _userEmailKey = 'user-email';
  static const _userJobTitleKey = 'user-job-title';
  static const _userPhoneKey = 'user-phone';
  static const _userCompanyNameKey = 'user-company-name';
  static const _userCompanyAddressKey = 'user-company-address';
  static const _userCompanyCountryKey = 'user-company-country';
  static const _userAccountNameKey = 'user-account-name';
  static const _userCompanyDomainKey = 'user-company-domain';
  static const _userToken = 'user-token';
  static const _rememberEmailKey = 'remember-email';
  static const _rememberPasswordKey = 'remember-password';

  const UserSecureStorage({
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  Future<void> upsertUser({
    required int id,
    required String name,
    String? lastName,
    required String slug,
    String? email,
    String? jobTitle,
    String? phone,
    String? companyName,
    String? companyAddress,
    String? companyCountry,
    String? accountName,
    String? companyDomain,
    required String token,
  }) async {
    await _secureStorage.write(
      key: _userIdKey,
      value: id.toString(),
    );
    await _secureStorage.write(
      key: _userNameKey,
      value: name,
    );
    await _secureStorage.write(
      key: _userLastNameKey,
      value: lastName,
    );
    await _secureStorage.write(
      key: _userSlugKey,
      value: slug,
    );
    await _secureStorage.write(
      key: _userEmailKey,
      value: email ?? '',
    );
    await _secureStorage.write(
      key: _userJobTitleKey,
      value: jobTitle ?? '',
    );
    await _secureStorage.write(
      key: _userPhoneKey,
      value: phone ?? '',
    );
    await _secureStorage.write(
      key: _userCompanyNameKey,
      value: companyName ?? '',
    );
    await _secureStorage.write(
      key: _userCompanyAddressKey,
      value: companyAddress ?? '',
    );
    await _secureStorage.write(
      key: _userCompanyCountryKey,
      value: companyCountry ?? '',
    );
    await _secureStorage.write(
      key: _userAccountNameKey,
      value: accountName ?? '',
    );
    await _secureStorage.write(
      key: _userCompanyDomainKey,
      value: companyDomain ?? '',
    );
    await _secureStorage.write(
      key: _userToken,
      value: token,
    );
  }

  Future<void> deleteUser() async {
    await _secureStorage.delete(key: _userIdKey);
    await _secureStorage.delete(key: _userNameKey);
    await _secureStorage.delete(key: _userLastNameKey);
    await _secureStorage.delete(key: _userSlugKey);
    await _secureStorage.delete(key: _userEmailKey);
    await _secureStorage.delete(key: _userJobTitleKey);
    await _secureStorage.delete(key: _userPhoneKey);
    await _secureStorage.delete(key: _userCompanyNameKey);
    await _secureStorage.delete(key: _userCompanyAddressKey);
    await _secureStorage.delete(key: _userCompanyCountryKey);
    await _secureStorage.delete(key: _userAccountNameKey);
    await _secureStorage.delete(key: _userCompanyDomainKey);
    await _secureStorage.delete(key: _userToken);
  }

  Future<int?> getUserId() async {
    final idString = await _secureStorage.read(key: _userIdKey);
    return idString != null ? int.tryParse(idString) : null;
  }

  Future<String?> getUserName() => _secureStorage.read(key: _userNameKey);

  Future<String?> getUserLastName() =>
      _secureStorage.read(key: _userLastNameKey);

  Future<String?> getUserSlug() => _secureStorage.read(key: _userSlugKey);

  Future<String?> getUserEmail() => _secureStorage.read(key: _userEmailKey);

  Future<String?> getUserJobTitle() =>
      _secureStorage.read(key: _userJobTitleKey);

  Future<String?> getUserPhone() => _secureStorage.read(key: _userPhoneKey);

  Future<String?> getUserCompanyName() =>
      _secureStorage.read(key: _userCompanyNameKey);

  Future<String?> getUserCompanyAddress() =>
      _secureStorage.read(key: _userCompanyAddressKey);

  Future<String?> getUserCompanyCountry() =>
      _secureStorage.read(key: _userCompanyCountryKey);

  Future<String?> getUserAccountName() =>
      _secureStorage.read(key: _userAccountNameKey);

  Future<String?> getUserCompanyDomain() =>
      _secureStorage.read(key: _userCompanyDomainKey);

  Future<String?> getUserToken() => _secureStorage.read(key: _userToken);

  Future<void> upsertRememberEmail({required String? email}) async {
    await _secureStorage.write(
      key: _rememberEmailKey,
      value: email,
    );
  }

  Future<String?> getRememberEmail() => _secureStorage.read(
        key: _rememberEmailKey,
      );

  Future<void> deleteRememberEmail() async =>
      await _secureStorage.delete(key: _rememberEmailKey);

  Future<void> upsertRememberPassword({required String? password}) async {
    await _secureStorage.write(
      key: _rememberPasswordKey,
      value: password,
    );
  }

  Future<String?> getRememberPassword() => _secureStorage.read(
        key: _rememberPasswordKey,
      );

  Future<void> deleteRememberPassword() async =>
      await _secureStorage.delete(key: _rememberPasswordKey);
}
