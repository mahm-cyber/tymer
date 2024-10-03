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
  static const _accessTokenJsonKey = 'access_token';
  static const _verificationErrorsJsonKey = 'verification_errors';
  static const _emailJsonKey = 'email';
  static const _phoneNumberJsonKey = 'phone_number';

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

  Future<UserRM> signIn({
    required String email,
    required String password,
  }) async {
    final url = urlBuilder.buildSignInUrl();

    final requestJsonBody = UserCredentialsRM(
      email: email,
      password: password,
    ).toJson();

    final response = await _dio.post(
      url,
      data: requestJsonBody,
    );
    try {
      final jsonObject = response.data;
      final user = UserRM.fromJson(jsonObject);
      return user;
    } catch (_) {
      final error = response.data[_errorJsonKey];
      final errorString = error.toString().toLowerCase();
      final invalidPassword = errorString.contains('password') == true;
      final invalidEmail = errorString.contains('user') == true;
      final invalidCredentials = invalidPassword || invalidEmail;
      if (invalidCredentials) {
        throw InvalidCredentialsTymerException();
      }

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
      final errorObject = error.response?.data[_verificationErrorsJsonKey];
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

  Future sendOtp({
    required String email,
  }) async {
    final url = urlBuilder.buildSendOtpUrl();

    try {
      final response = await _dio.post(
        url,
        data: {"email": email},
      );
      final error = response.data[_errorJsonKey];
      final phoneNotRegistered =
          error.toString().toLowerCase().contains('user');
      if (phoneNotRegistered) throw EmailNotRegisteredTymerException();
      final otp = response.data[_otpJsonKey].toString();
      debugPrint('----otp: $otp');
    } catch (_) {
      rethrow;
    }
  }

  Future verifyOtp({
    required String email,
    required String otp,
  }) async {
    final url = urlBuilder.buildVerifyOtpUrl();

    try {
      final response = await _dio.post(
        url,
        data: {
          "email": email,
          "otp": otp,
        },
      );
      final error = response.data[_errorJsonKey];
      final invalidOtp =
          error.toString().toLowerCase().contains('invalid') == true;
      if (invalidOtp) throw InvalidOtpTymerException();
    } catch (_) {
      rethrow;
    }
  }

  Future resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final url = urlBuilder.buildResetPasswordUrl();

    try {
      await _dio.post(
        url,
        data: {
          "email": email,
          "password": newPassword,
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
              "auth": token,
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
