import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tymer_api/tymer_api.dart';

class AuthApi {
  static const _errorJsonKey = 'error';
  static const _dataJsonKey = 'data';
  static const _contentJsonKey = 'content';
  static const _accessTokenJsonKey = 'access_token';
  static const _verificationErrorsJsonKey = 'verification_errors';
  static const _emailJsonKey = 'email';
  static const _phoneNumberJsonKey = 'phone_number';
  static const _currentPasswordJsonKey = 'current_password';
  static const _codeJsonKey = 'code';
  static const _messageJsonKey = 'message';
  static const _phoneOtpMismatchJsonKey =
      'PHONE_NUMBER_VERIFICATION_OTP_MISMATCH';
  static const _rateLimitedJsonKey = 'RATE_LIMITED';
  static const _validationErrorJsonKey = 'VALIDATION_ERROR';

  final Dio _dio;
  final UrlBuilder _urlBuilder;

  AuthApi(
    this._dio,
    this._urlBuilder,
  );

  //Auth
  Future<String> signIn({
    required String phone,
    required String password,
  }) async {
    final url = _urlBuilder.buildSignInUrl();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final isAndroid = Platform.isAndroid;
    final androidInfo = isAndroid ? await deviceInfo.androidInfo : null;
    final isHuwaei =
        androidInfo?.manufacturer.toLowerCase().contains('huawei') == true;
    final isIos = Platform.isIOS;
    final token = isHuwaei
        ? ''
        : isIos
            ? await FirebaseMessaging.instance.getAPNSToken()
            : await FirebaseMessaging.instance.getToken();

    final requestJsonBody = UserCredentialsRM(
      phone: '+2$phone',
      password: password,
      pushTokenType: isHuwaei ? 'huwaei' : 'fcm',
      pushToken: token ?? '',
    ).toJson();

    try {
      final response = await _dio.post(
        url,
        data: requestJsonBody,
      );
      final token = response.data[_accessTokenJsonKey];
      return token;
    } on DioException catch (error) {
      if (error.error is SocketException) {
        rethrow;
      }
      final errorObject =
          error.response?.data[_errorJsonKey][_verificationErrorsJsonKey];
      if (errorObject != null && errorObject.containsKey(_phoneNumberJsonKey)) {
        throw InvalidCredentialsTymerException();
      }
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future signOut() async {
    final url = _urlBuilder.buildSignOutUrl();

    try {
      await _dio.post(url);
    } catch (_) {
      rethrow;
    }
  }

  Future<UserRM> getUser() async {
    final url = _urlBuilder.buildGetUserUrl();

    try {
      final response = await _dio.get(url);
      final user = UserRM.fromJson(response.data[_dataJsonKey]);
      return user;
    } catch (_) {
      rethrow;
    }
  }

  Future<String> requestOtpForSignUp({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phone,
    required String name,
  }) async {
    final url = _urlBuilder.buildSignUpUrl();

    final requestJsonBody = UserSignUpRM(
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      phone: '+2$phone',
      name: name,
    ).toJson();

    try {
      final response = await _dio.post(
        url,
        data: requestJsonBody,
      );
      final userToken = response.data[_accessTokenJsonKey] as String;
      return userToken;
    } on DioException catch (error) {
      final errorObject =
          error.response?.data[_errorJsonKey][_verificationErrorsJsonKey];
      if (errorObject.containsKey(_emailJsonKey)) {
        final arabicValidation =
            errorObject[_emailJsonKey].first.contains('تم أخذها مسبقاً');
        final englishValidation =
            errorObject[_emailJsonKey].first.contains('has already been taken');
        if (arabicValidation || englishValidation) {
          throw EmailAlreadyRegisteredTymerException();
        }
      }
      if (errorObject.containsKey(_phoneNumberJsonKey)) {
        final arabicValidation =
            errorObject[_phoneNumberJsonKey].first.contains('تم أخذها مسبقاً');
        final englishValidation = errorObject[_phoneNumberJsonKey]
            .first
            .contains('has already been taken');
        if (arabicValidation || englishValidation) {
          throw PhoneAlreadyRegisteredTymerException();
        }
      }

      rethrow;
    }
  }

  Future reSendOtp() async {
    final url = _urlBuilder.buildReSendOtpUrl();

    try {
      await _dio.post(
        url,
      );
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];

      if (errorObject[_codeJsonKey].contains('RATE_LIMITED')) {
        // extract the integer from this string لقد قمت بعمل الكثير من الطلبات. يرجى المحاولة مرة أخرى بعد 137 ثانية.
        final rateLimitedMessage = errorObject[_messageJsonKey] as String;
        final rateLimitedSeconds = int.parse(
          rateLimitedMessage
              .split(' ')[rateLimitedMessage.split(' ').length - 2],
        );
        throw RateLimitedTymerException(rateLimitedSeconds);
      }
      rethrow;
    }
  }

  Future requestOtpForForgotPassword({
    required String phone,
  }) async {
    final url = _urlBuilder.buildForgotPasswordUrl();

    try {
      await _dio.post(
        url,
        data: {
          "phone_number": '+2$phone',
        },
      );
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];
      if (errorObject[_codeJsonKey].contains('RATE_LIMITED')) {
        final rateLimitedMessage = errorObject[_messageJsonKey] as String;
        final rateLimitedSeconds = int.parse(
          rateLimitedMessage
              .split(' ')[rateLimitedMessage.split(' ').length - 2],
        );
        throw RateLimitedTymerException(rateLimitedSeconds);
      }
      rethrow;
    }
  }

  Future requestOtpForChangePhone({
    required String phone,
    required String password,
  }) async {
    final url = _urlBuilder.buildChangePhoneUrl();

    try {
      await _dio.post(
        url,
        data: {
          "new_phone_number": '+2$phone',
          "current_password": password,
        },
      );
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];
      if (errorObject[_codeJsonKey].contains(_validationErrorJsonKey) &&
          errorObject[_verificationErrorsJsonKey]
              .containsKey('current_password')) {
        throw IncorrectPasswordTymerException();
      }
      if (errorObject[_codeJsonKey].contains(_validationErrorJsonKey) &&
          errorObject[_verificationErrorsJsonKey]
              .containsKey('new_phone_number')) {
        throw PhoneAlreadyRegisteredTymerException();
      }
      rethrow;
    }
  }

  Future changeLanguage({
    required String language,
  }) async {
    final url = _urlBuilder.buildChangeLanguageUrl();

    try {
      await _dio.post(
        url,
        data: {
          "preferred_language": language,
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  Future verifyOtpForChangePhone({
    required String otp,
  }) async {
    final url = _urlBuilder.buildVerifyOtpForChangePhoneUrl();

    try {
      await _dio.post(
        url,
        data: {
          "otp_code": otp,
        },
      );
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];
      if (errorObject[_codeJsonKey].contains(_phoneOtpMismatchJsonKey)) {
        throw InvalidOtpTymerException();
      }
      if (errorObject[_codeJsonKey]
          .contains('PHONE_NUMBER_ALREADY_REGISTERED')) {
        throw PhoneAlreadyRegisteredTymerException();
      }

      if (errorObject[_codeJsonKey].contains('RATE_LIMITED')) {
        final rateLimitedMessage = errorObject[_messageJsonKey] as String;
        final rateLimitedSeconds = int.parse(
          rateLimitedMessage
              .split(' ')[rateLimitedMessage.split(' ').length - 2],
        );
        throw RateLimitedTymerException(rateLimitedSeconds);
      }
      rethrow;
    }
  }

  Future verifyOtp({
    required String otp,
  }) async {
    final url = _urlBuilder.buildVerifyOtpUrl();

    try {
      await _dio.post(
        url,
        data: {
          "otp_code": otp,
        },
      );
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];
      if (errorObject[_codeJsonKey].contains(_phoneOtpMismatchJsonKey)) {
        throw InvalidOtpTymerException();
      }
      if (errorObject[_codeJsonKey].contains(_rateLimitedJsonKey)) {
        final rateLimitedMessage = errorObject[_messageJsonKey] as String;
        final rateLimitedSeconds = int.parse(
          rateLimitedMessage
              .split(' ')[rateLimitedMessage.split(' ').length - 2],
        );
        throw RateLimitedTymerException(rateLimitedSeconds);
      }
      rethrow;
    }
  }

  Future resetPassword({
    required String phone,
    required String otp,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final url = _urlBuilder.buildResetPasswordUrl();

    try {
      await _dio.post(
        url,
        data: {
          "phone_number": '+2$phone',
          "otp_code": otp,
          "password": newPassword,
          "password_confirmation": newPasswordConfirmation,
        },
      );
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];
      if (errorObject[_codeJsonKey].contains(_phoneOtpMismatchJsonKey)) {
        throw InvalidOtpTymerException();
      }
      if (errorObject[_codeJsonKey].contains('RATE_LIMITED')) {
        final rateLimitedMessage = errorObject[_messageJsonKey] as String;
        final rateLimitedSeconds = int.parse(
          rateLimitedMessage
              .split(' ')[rateLimitedMessage.split(' ').length - 2],
        );
        throw RateLimitedTymerException(rateLimitedSeconds);
      }
      rethrow;
    }
  }

  Future<PrivacyPolicyRM> getPrivacyPolicy() async {
    final url = _urlBuilder.buildGetPrivacyPolicyUrl();
    try {
      final response = await _dio.get(url);
      final privacyPolicy = PrivacyPolicyRM.fromJson(
          response.data[_dataJsonKey][_contentJsonKey]);
      return privacyPolicy;
    } catch (error) {
      rethrow;
    }
  }

  Future changePassword({
    required String password,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final url = _urlBuilder.buildChangePasswordUrl();
    final requestJsonBody = {
      'current_password': password,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    };
    try {
      await _dio.post(
        url,
        data: requestJsonBody,
      );
    } on DioException catch (error) {
      final errorObject =
          error.response?.data[_errorJsonKey][_verificationErrorsJsonKey];
      if (errorObject.containsKey(_currentPasswordJsonKey)) {
        throw IncorrectPasswordTymerException();
      }
      rethrow;
    }
  }

  Future<void> sendFcmToken(String fcmToken) async {
    final url = _urlBuilder.buildSendFcmTokenUrl();
    await _dio.post(
      url,
      data: {
        'fcm_token': fcmToken,
      },
    );
  }

  Future deleteAccount({
    required String password,
  }) async {
    final url = _urlBuilder.buildDeleteAccountUrl();
    try {
      await _dio.delete(
        url,
        data: {
          'current_password': password,
        },
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == 422) {
        throw IncorrectPasswordTymerException();
      }
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
