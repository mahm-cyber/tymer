import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:tymer_api/tymer_api.dart';
import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/src/mappers/mappers.dart';
import 'package:user_repository/src/user_change_notifier.dart';
import 'package:user_repository/src/user_local_storage.dart';
import 'package:user_repository/src/user_secure_storage.dart';

class UserRepository {
  UserRepository({
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

  Future reSendOtp() async {
    try {
      await remoteApi.reSendOtp();
    } catch (error) {
      if (error is RateLimitedTymerException) {
        throw OtpRateLimitExceededException(
          error.seconds,
        );
      }
      rethrow;
    }
  }

  Future requestOtpForForgotPassword({
    required String phone,
  }) async {
    try {
      await remoteApi.requestOtpForForgotPassword(
        phone: phone,
      );
      final otpVerification = OtpVerification(
        phone: phone,
        reason: OtpVerificationReason.forgotPassword,
      );
      changeNotifier.setOtpVerification(otpVerification);
    } catch (error) {
      if (error is RateLimitedTymerException) {
        throw OtpRateLimitExceededException(
          error.seconds,
        );
      }
      rethrow;
    }
  }

  Future requestOtpForChangePhone({
    required String phone,
    required String password,
  }) async {
    try {
      await remoteApi.requestOtpForChangePhone(
        phone: phone,
        password: password,
      );
      final otpVerification = OtpVerification(
        phone: phone,
        reason: OtpVerificationReason.changePhone,
      );
      changeNotifier.setOtpVerification(otpVerification);
    } catch (error) {
      if (error is IncorrectPasswordTymerException) {
        throw IncorrectPasswordException();
      }
      if (error is RateLimitedTymerException) {
        throw OtpRateLimitExceededException(
          error.seconds,
        );
      }
      if (error is PhoneAlreadyRegisteredTymerException) {
        throw PhoneAlreadyRegisteredException();
      }
      rethrow;
    }
  }

  Future changeLanguage({
    required LocalePreferenceDM language,
  }) async {
    final languageStr = localePreferenceDMToStr(language);
    try {
      await remoteApi.changeLanguage(language: languageStr);
    } catch (error) {
      rethrow;
    }
  }

  Future verifyOtpForChangePhone(String otp) async {
    try {
      await remoteApi.verifyOtpForChangePhone(
        otp: otp,
      );
      _secureStorage.deleteRememberPhone();
    } catch (error) {
      if (error is InvalidOtpTymerException) {
        throw InvalidOtpException();
      }
      if (error is RateLimitedTymerException) {
        throw OtpRateLimitExceededException(
          error.seconds,
        );
      }
      if (error is PhoneAlreadyRegisteredTymerException) {
        throw PhoneAlreadyRegisteredException();
      }
      rethrow;
    }
  }

  Future signIn({
    required String phone,
    required String password,
  }) async {
    try {

      final token = await remoteApi.signIn(
        phone: phone,
        password: password,
      );
      await _secureStorage.upsertUserToken(token: token);
      final userRM = await remoteApi.getUser();

      final isPhoneVerified = userRM.phoneVerifiedAt != null;


      if (!isPhoneVerified) {
        await reSendOtp();
        final otpVerification = OtpVerification(
          phone: phone,
          password: password,
          reason: OtpVerificationReason.login,
        );
        changeNotifier.setOtpVerification(otpVerification);
        throw PhoneNotVerifiedException();
      }

      await _secureStorage.upsertUser(
        id: userRM.id,
        name: userRM.name,
        email: userRM.email,
        phone: userRM.phone,
      );
      final language = userRM.language;
      final localePreference = strToLocalePreferenceDM(language);
      await upsertLocalePreference(localePreference);
      final userDM = userRM.toDomainModel();
      _userSubject.add(
        userDM,
      );
    } catch (error) {
      if (error is InvalidCredentialsTymerException) {
        throw InvalidCredentialsException();
      }
      if (error is RateLimitedTymerException) {
        throw OtpRateLimitExceededException(
          error.seconds,
        );
      }
      rethrow;
    }
  }



  Future requestOtpForSignUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String passwordConfirmation,
  }) async {
    try {
      final token = await remoteApi.requestOtpForSignUp(
        email: email,
        password: password,
        name: name,
        phone: phone,
        passwordConfirmation: passwordConfirmation,
      );

      await _secureStorage.upsertUserToken(token: token);
      final otpVerification = OtpVerification(
        phone: phone,
        // This password is passed on so that it can be used to sign in the user
        password: password,
        reason: OtpVerificationReason.register,
      );
      changeNotifier.setOtpVerification(otpVerification);
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

  Future verifyOtpForRegistrationOrLogin(
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
        throw OtpRateLimitExceededException(
          error.seconds,
        );
      }
      rethrow;
    }
  }

  Future<void> verifyOtpForPasswordReset({
    required String otp,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final phone = changeNotifier.otpVerification!.phone;

      await remoteApi.resetPassword(
        otp: otp,
        phone: phone,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
    } catch (error) {
      if (error is InvalidOtpTymerException) {
        throw InvalidOtpException();
      }
      if (error is RateLimitedTymerException) {
        throw OtpRateLimitExceededException(
          error.seconds,
        );
      }
      rethrow;
    }
  }

  Future<List<ReservationServiceType>>
      _getReservationServiceTypesFromNetwork() async {
    try {
      final reservationServiceTypes =
          await remoteApi.getReservationServiceTypes();
      final reservationServiceTypesCM = reservationServiceTypes.toCacheModel();
      _localStorage.upsertReservationServiceTypes(reservationServiceTypesCM);
      final reservationServiceTypesDM = reservationServiceTypes.toDomainModel();
      return reservationServiceTypesDM;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<ReservationServiceType>> getReservationServiceTypes(
    FetchPolicy fetchPolicy,
  ) async {
    try {
      if (fetchPolicy == FetchPolicy.networkOnly) {
        return _getReservationServiceTypesFromNetwork();
      }
      final storedReservationServiceTypesCM =
          await _localStorage.getReservationServiceTypes();
      if (storedReservationServiceTypesCM == null) {
        return _getReservationServiceTypesFromNetwork();
      } else {
        final storedReservationServiceTypes =
            storedReservationServiceTypesCM.toDomainModel();
        return storedReservationServiceTypes;
      }
    } catch (error) {
      rethrow;
    }
  }



  Future<String?> getUserToken() async => await _secureStorage.getUserToken();

  Future logout() async {
    try {
      await remoteApi.signOut();
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

  Future<Settings> _getSettingsFromNetwork() async {
    try {
      //future.wait

      final settings = await Future.wait(
        [
          remoteApi.getPrivacyPolicy(),
          remoteApi.getTermsAndConditions(),
        ],
      );
      final currentSettings = await _localStorage.getSettings();
      final privacyPolicyCM = (settings[0] as PrivacyPolicyRM).toCacheModel();
      final termsAndConditionsCM =
          (settings[1] as TermsAndConditionsRM).toCacheModel();
      final settingsCM = currentSettings?.copyWith(
            privacyPolicy: privacyPolicyCM,
            termsAndConditions: termsAndConditionsCM,
          ) ??
          SettingsCM(
            privacyPolicy: privacyPolicyCM,
            termsAndConditions: termsAndConditionsCM,
          );

      final privacyPolicyDM = (settings[0] as PrivacyPolicyRM).toDomainModel();
      final termsAndConditionsDM =
          (settings[1] as TermsAndConditionsRM).toDomainModel();
      final settingsDM = Settings(
        privacyPolicy: privacyPolicyDM,
        termsAndConditions: termsAndConditionsDM,
      );

      _localStorage.upsertSettings(settingsCM);
      return settingsDM;
    } catch (error) {
      rethrow;
    }
  }

  Future<Settings> getSettings(FetchPolicy fetchPolicy) async {
    try {
      if (fetchPolicy == FetchPolicy.networkOnly) {
        final settings = await _getSettingsFromNetwork();
        return settings;
      }
      final storedSettingsCM = await _localStorage.getSettings();
      if (storedSettingsCM == null) {
        final settings = await _getSettingsFromNetwork();
        return settings;
      } else {
        final storedSettings = storedSettingsCM.toDomainModel();
        return storedSettings;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<PricingSettings> _getPricingSettingsFromNetwork() async {
    try {
      final pricingSettingsRM = await remoteApi.getPricingSettings();
      final pricingSettingsDM = pricingSettingsRM.toDomainModel();
      final pricingSettingsCM = pricingSettingsRM.toCacheModel();
      final currentSettings = await _localStorage.getSettings() ??
          SettingsCM(
            pricing: pricingSettingsCM,
          );
      final updatedSettings = currentSettings.copyWith(
        pricing: pricingSettingsCM,
      );
      _localStorage.upsertSettings(updatedSettings);
      return pricingSettingsDM;
    } catch (error) {
      rethrow;
    }
  }

  Future<PricingSettings> getPricingSettings(FetchPolicy fetchPolicy) async {
    try {
      if (fetchPolicy == FetchPolicy.networkOnly) {
        final pricingSettings = await _getPricingSettingsFromNetwork();
        return pricingSettings;
      }
      final storedSettingsCM = await _localStorage.getSettings();
      if (storedSettingsCM?.pricing == null) {
        final pricingSettings = await _getPricingSettingsFromNetwork();
        return pricingSettings;
      } else {
        final storedPricingSettings =
            storedSettingsCM!.pricing!.toDomainModel();
        return storedPricingSettings;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<LocationData?> getUserLocation() async {
    try {
      Location location = Location();

      bool serviceEnabled;
      PermissionStatus permissionStatus;

      permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
        if (permissionStatus == PermissionStatus.deniedForever) {
          await Geolocator.openAppSettings();
          return null;
        }
        if (permissionStatus != PermissionStatus.granted) {
          return null;
        }
      }

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return null;
        }
      }

      await Future.delayed(const Duration(milliseconds: 100));
      final locationData = await location.getLocation();
      return locationData;
    } catch (error) {
      rethrow;
    }
  }

  Future changePassword({
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      await remoteApi.changePassword(
        password: password,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );
      // clear remembered password
      await _secureStorage.deleteRememberPassword();
    } catch (error) {
      if (error is IncorrectPasswordTymerException) {
        throw IncorrectPasswordException();
      }
      rethrow;
    }
  }
}

enum FetchPolicy {
  networkOnly,
  cachePreferably,
}
