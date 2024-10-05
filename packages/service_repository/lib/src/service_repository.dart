import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tymer_api/tymer_api.dart';
import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:service_repository/src/mappers/mappers.dart';
import 'package:service_repository/src/user_change_notifier.dart';
import 'package:service_repository/src/user_local_storage.dart';
import 'package:service_repository/src/user_secure_storage.dart';

class ServiceRepository {
  ServiceRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  })  : _secureStorage = const UserSecureStorage(),
        changeNotifier = UserChangeNotifier(),
        _localStorage = UserLocalStorage(noSqlStorage: noSqlStorage);

  final TymerApi remoteApi;
  final UserSecureStorage _secureStorage;
  final UserLocalStorage _localStorage;
  final BehaviorSubject<User?> _userSubject = BehaviorSubject();
  final UserChangeNotifier changeNotifier;
  final BehaviorSubject<LocalePreferenceDM?> _localePreferenceSubject =
      BehaviorSubject();

  Future<void> upsertLocalePreference(LocalePreferenceDM preference) async {
    await _localStorage.upsertLocalePreference(
      preference.toCacheModel(),
    );
    _localePreferenceSubject.add(preference);
    final cachedLocale = await getLocalePreference().first;
    debugPrint('cachedLocale: $cachedLocale');
  }

  Stream<LocalePreferenceDM?> getLocalePreference() async* {
    // if (!_localePreferenceSubject.hasValue) {
    final storedPreferenceCM = await _localStorage.getLocalePreference();
    final storedPreference = storedPreferenceCM?.toDomainModel();
    // final storedPreference = LocalePreferenceCM.arabic.toDomainModel();
    if (storedPreferenceCM == null) {
      // final String systemLocale = Platform.localeName;
      // final defaultLocalePreference = strToLocalePreferenceDM(systemLocale);
      // upsertLocalePreference(defaultLocalePreference);
    } else {
      _localePreferenceSubject.add(storedPreference);
    }
    // }

    yield* _localePreferenceSubject.stream;
  }

  Future sendOtp() async {
    try {
      await remoteApi.sendOtp();
    } catch (error) {
      if (error is RateLimitedTymerException) {
        throw OtpRateLimitExceededException();
      }
      rethrow;
    }
  }

  Future sendOtpForForgotPassword({
    required String phone,
  }) async {
    try {
      await remoteApi.forgotPassword(
        phone: phone,
      );
    } catch (error) {
      if (error is RateLimitedTymerException) {
        throw OtpRateLimitExceededException();
      }
      rethrow;
    }
  }

  Future signIn({
    required String phone,
    required String password,
  }) async {
    try {
      await cacheRememberedCredentials(
        phone: phone,
        password: password,
      );
      final token = await remoteApi.signIn(
        phone: phone,
        password: password,
      );
      _secureStorage.upsertUserToken(token: token);
      final userRM = await remoteApi.getUser();
      final isPhoneVerified = userRM.phoneVerifiedAt != null;
      final userDM = userRM.toDomainModel();
      await _secureStorage.upsertUser(
        id: userRM.id,
        name: userRM.name,
        email: userRM.email,
        phone: userRM.phone,
      );

      if (!isPhoneVerified) {
        await sendOtp();
        final otpVer = OtpVerification(
          phone: phone,
          reason: OtpVerificationReason.login,
        );
        changeNotifier.setOtpVerification(otpVer);
        throw PhoneNotVerifiedException();
      }

      _userSubject.add(
        userDM,
      );
    } catch (error) {
      if (error is InvalidCredentialsTymerException) {
        throw InvalidCredentialsException();
      }
      if (error is RateLimitedTymerException) {
        throw OtpRateLimitExceededException();
      }
      rethrow;
    }
  }

  Future signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String passwordConfirmation,
  }) async {
    try {
      final token = await remoteApi.signUp(
        email: email,
        password: password,
        name: name,
        phone: phone,
        passwordConfirmation: passwordConfirmation,
      );
      await _secureStorage.upsertUserToken(token: token);
      final otpVerification = OtpVerification(
        phone: phone,
        reason: OtpVerificationReason.register,
      );
      changeNotifier.setOtpVerification(otpVerification);
      final userRM = await remoteApi.getUser();
      final userDM = userRM.toDomainModel();
      await _secureStorage.upsertUser(
        id: userRM.id,
        name: name,
        email: email,
        phone: phone,
      );

      _userSubject.add(
        userDM,
      );
    } catch (error) {
      if (error is EmailAlreadyRegisteredTymerException) {
        throw EmailAlreadyRegisteredException();
      }
      if (error is PhoneAlreadyRegisteredTymerException) {
        throw PhoneAlreadyRegisteredException();
      }
      rethrow;
    }
  }

  Future verifyOtp(
    String otp,
  ) async {
    try {
      await remoteApi.verifyOtp(
        otp: otp,
      );
    } catch (error) {
      if (error is InvalidOtpTymerException) {
        throw InvalidOtpException();
      }
      if (error is RateLimitedTymerException) {
        throw OtpRateLimitExceededException();
      }
      rethrow;
    }
  }

  Future<void> resetPassword(
      {required String newPassword,
      required String newPasswordConfirmation,
      required}) async {
    try {
      final phone = changeNotifier.otpVerification!.phone;

      await remoteApi.resetPassword(
        phone: phone,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future updateUser({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? jobTitle,
    String? image,
  }) async {
    try {
      // final user = await getUser().first;
      // await remoteApi.updateProfile(
      //   userId: user!.id,
      //   firstName: firstName,
      //   lastName: lastName,
      //   email: email,
      //   phone: phone,
      //   jobTitle: jobTitle,
      //   image: image,
      // );
    } catch (error) {
      rethrow;
    }
  }

  Future<String?> getUserToken() async => await _secureStorage.getUserToken();

  Future logout() async {
    try {
      await _secureStorage.deleteUser();
      _userSubject.add(null);
    } catch (error) {
      rethrow;
    }
  }

  Stream<User?> getUser() async* {
    // Check if there is a [User] value added to the stream, if not,
    // this means that we need to first get the [User] data from
    // the secure storage in order to be able to add a [User].
    // if (!_userSubject.hasValue) {
    final userId = await _secureStorage.getUserId();
    final userName = await _secureStorage.getUserName();
    final userEmail = await _secureStorage.getUserEmail();
    final userPhone = await _secureStorage.getUserPhone();

    if (userId != null &&
        userName != null &&
        userEmail != null &&
        userPhone != null) {
      final user = User(
        id: userId,
        name: userName,
        email: userEmail,
        phone: userPhone,
      );
      _userSubject.add(user);
    } else {
      _userSubject.add(null);
    }
    yield* _userSubject.stream;
  }

  Future cacheRememberedCredentials({
    required String phone,
    required String password,
  }) async {
    await _secureStorage.upsertRememberPhone(phone: phone);
    await _secureStorage.upsertRememberPassword(password: password);
  }

  Future<RememberMe> getRememberedCredentials() async {
    final email = await _secureStorage.getRememberPhone();
    final password = await _secureStorage.getRememberPassword();
    final rememberMe = RememberMe(
      password: password,
      phone: email,
    );
    return rememberMe;
  }

  Future deleteRememberedCredentials() async {
    await _secureStorage.deleteRememberPhone();
    await _secureStorage.deleteRememberPassword();
  }
}
