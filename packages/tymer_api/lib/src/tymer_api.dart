import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as diox;
import 'package:flutter/material.dart';
import 'package:tymer_api/tymer_api.dart';
import 'package:tymer_api/src/models/auth/request/update_account_rm.dart';
import 'package:tymer_api/src/url_builder.dart';

typedef UserTokenSupplier = Future<String?> Function();

class TymerApi {
  static const _errorJsonKey = 'error';
  static const _otpJsonKey = 'otp';
  static const _dataJsonKey = 'data';
  static const _accessTokenJsonKey = 'access_token';
  static const _verificationErrorsJsonKey = 'verification_errors';
  static const _emailJsonKey = 'email';
  static const _phoneNumberJsonKey = 'phone_number';
  static const _codeJsonKey = 'code';

  TymerApi({
    required UserTokenSupplier userTokenSupplier,
    required this.isUserUnAuthenticatedVN,
    required this.internetConnectionErrorVN,
  })  : urlBuilder = UrlBuilder(),
        _dio = Dio() {
    _dio.setUpAuthHeaders(
      userTokenSupplier: userTokenSupplier,
      isUserUnAuthSC: isUserUnAuthenticatedVN,
      internetConnectionErrorVN: internetConnectionErrorVN,
    );
    _dio.interceptors.add(
      LogInterceptor(
        error: false,
        request: false,
        requestBody: false,
        requestHeader: false,
        responseBody: false,
        responseHeader: false,
        logPrint: (_) {},
      ),
    );
  }

  // final FirebaseMessaging _firebaseMessaging;
  final Dio _dio;
  final ValueNotifier<bool> isUserUnAuthenticatedVN;
  final ValueNotifier internetConnectionErrorVN;
  final UrlBuilder urlBuilder;

  Future<String> signIn({
    required String phone,
    required String password,
  }) async {
    final url = urlBuilder.buildSignInUrl();

    final requestJsonBody = UserCredentialsRM(
      phone: '+2$phone',
      password: password,
    ).toJson();

    try {
      final response = await _dio.post(
        url,
        data: requestJsonBody,
      );
      final token = response.data[_accessTokenJsonKey];
      return token;
    } on DioException catch (error) {
      final errorObject =
          error.response?.data[_errorJsonKey][_verificationErrorsJsonKey];
      if (errorObject.containsKey(_phoneNumberJsonKey)) {
        throw InvalidCredentialsTymerException();
      }
      rethrow;
    }
  }

  Future<UserRM> getUser() async {
    final url = urlBuilder.buildGetUserUrl();

    try {
      final response = await _dio.get(url);
      final user = UserRM.fromJson(response.data[_dataJsonKey]);
      return user;
    } catch (_) {
      rethrow;
    }
  }

  Future<String> signUp({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String phone,
    required String name,
  }) async {
    final url = urlBuilder.buildSignUpUrl();

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
      if (errorObject.containsKey(_emailJsonKey) &&
          errorObject[_emailJsonKey].first.contains('تم أخذها مسبقاً')) {
        throw EmailAlreadyRegisteredTymerException();
      }
      if (errorObject.containsKey(_phoneNumberJsonKey) &&
          errorObject[_phoneNumberJsonKey].first.contains('تم أخذها مسبقاً')) {
        throw PhoneAlreadyRegisteredTymerException();
      }

      rethrow;
    }
  }

  Future updateProfile({
    required int userId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? jobTitle,
    String? image,
  }) async {
    final url = urlBuilder.buildUpdateUserUrl();

    final requestJsonBody = UpdateProfileUpRM(
      id: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      jobTitle: jobTitle,
      image: image,
    ).toJson();

    try {
      await _dio.post(
        url,
        data: requestJsonBody,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future updateAccount({
    required int userId,
    String? accountName,
    String? companyName,
    String? companyAddress,
    String? companyCountry,
  }) async {
    final url = urlBuilder.buildUpdateAccountUrl();

    final requestJsonBody = UpdateAccountRM(
      id: userId,
      accountName: accountName,
      companyName: companyName,
      companyAddress: companyAddress,
      companyCountry: companyCountry,
    ).toJson();

    try {
      await _dio.post(
        url,
        data: requestJsonBody,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    final url = urlBuilder.buildChangePasswordUrl();

    final requestJsonBody = ChangePasswordRM(
      email: email,
      oldPassword: oldPassword,
      newPassword: newPassword,
    ).toJson();

    try {
      final response = await _dio.post(
        url,
        data: requestJsonBody,
      );
      final responseValue = response.data[_errorJsonKey];
      if (responseValue is String &&
          responseValue.toLowerCase().contains('token invalid')) {
        throw IncorrectPasswordTymerException();
      }
    } catch (_) {
      rethrow;
    }
  }

  Future sendOtp() async {
    final url = urlBuilder.buildSendOtpUrl();

    try {
      await _dio.post(
        url,
      );
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];

      if (errorObject[_codeJsonKey].contains('RATE_LIMITED')) {
        throw RateLimitedTymerException();
      }
      rethrow;
    }
  }

  Future forgotPassword({
    required String phone,
  }) async {
    final url = urlBuilder.buildForgotPasswordUrl();

    try {
      await _dio.post(
        url,
        data: {
          "phone_number": '2+$phone',
        },
      );
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];
      if (errorObject[_codeJsonKey].contains('RATE_LIMITED')) {
        throw RateLimitedTymerException();
      }
      rethrow;
    }
  }

  Future verifyOtp({
    required String otp,
  }) async {
    final url = urlBuilder.buildVerifyOtpUrl();

    try {
      await _dio.post(
        url,
        data: {
          "otp_code": otp,
        },
      );
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];
      if (errorObject[_codeJsonKey]
          .contains('PHONE_NUMBER_VERIFICATION_OTP_MISMATCH')) {
        throw InvalidOtpTymerException();
      }
      if (errorObject[_codeJsonKey].contains('RATE_LIMITED')) {
        throw RateLimitedTymerException();
      }
      rethrow;
    }
  }

  Future resetPassword({
    required String phone,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final url = urlBuilder.buildResetPasswordUrl();

    try {
      await _dio.post(
        url,
        data: {
          "email": phone,
          "password": newPassword,
          "password_confirmation": newPasswordConfirmation,
        },
      );
    } catch (_) {
      rethrow;
    }
  }
}

extension on Dio {
  void setUpAuthHeaders({
    required UserTokenSupplier userTokenSupplier,
    required ValueNotifier<bool> isUserUnAuthSC,
    required ValueNotifier internetConnectionErrorVN,
  }) async {
    options = diox.BaseOptions(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
    );
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await userTokenSupplier();
          options.headers.addAll(
            {
              "Accept": "application/json",
              if (token != null) "Authorization": "Bearer $token",
              "X-API-Key": "01f64a264be7442a9008abda93d5d6ae",
            },
          );

          return handler.next(options);
        },
        onError: (error, handler) {
          final isCustomerUnAuth = error.response?.statusCode == 401;
          final internetConnectionError =
              error.type == DioExceptionType.connectionError;
          if (isCustomerUnAuth) isUserUnAuthSC.value = (true);
          if (internetConnectionError) {
            final internetConnectionException =
                InternetConnectionTymerException();
            internetConnectionErrorVN.value = internetConnectionException;
            internetConnectionErrorVN.value = null;
          }
          return handler.next(error);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
      ),
    );
  }
}
