import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as diox;
import 'package:flutter/material.dart';
import 'package:tymer_api/tymer_api.dart';

typedef UserTokenSupplier = Future<String?> Function();

class TymerApi {
  static const _errorJsonKey = 'error';
  static const _dataJsonKey = 'data';
  static const _accessTokenJsonKey = 'access_token';
  static const _verificationErrorsJsonKey = 'verification_errors';
  static const _emailJsonKey = 'email';
  static const _phoneNumberJsonKey = 'phone_number';
  static const _codeJsonKey = 'code';

  TymerApi({
    required UserTokenSupplier userTokenSupplier,
    required this.isUserUnAuthSC,
    required this.internetConnectionErrorVN,
  })  : urlBuilder = UrlBuilder(),
        _dio = Dio() {
    _dio.setUpAuthHeaders(
      userTokenSupplier: userTokenSupplier,
      isUserUnAuthSC: isUserUnAuthSC,
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
  final ValueNotifier<bool> isUserUnAuthSC;
  final ValueNotifier internetConnectionErrorVN;
  final UrlBuilder urlBuilder;

  //Auth
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

  Future signOut() async {
    final url = urlBuilder.buildSignOutUrl();

    try {
      await _dio.post(url);
    } catch (_) {
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

  //Request Service
  Future<ReservationServiceTypesRM> getReservationServiceTypes() async {
    final url = urlBuilder.buildGetReservationServiceTypesUrl();

    try {
      final response = await _dio.get(url);
      final reservationServiceTypes =
          ReservationServiceTypesRM.fromJson(response.data);
      return reservationServiceTypes;
    } catch (_) {
      rethrow;
    }
  }

  Future<int> requestService({
    required RequestServiceRM requestServiceRM,
  }) async {
    final url = urlBuilder.buildRequestServiceUrl();

    final requestJsonBody = requestServiceRM.toJson();

    try {
      final response = await _dio.post(
        url,
        data: requestJsonBody,
      );
      final requestId = response.data[_dataJsonKey]['id'] as int;
      debugPrint(response.data.toString());
      return requestId;
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];
      if (errorObject[_codeJsonKey].contains('INSUFFICIENT_BALANCE')) {
        throw InsufficientBalanceTymerException();
      }
      rethrow;
    }
  }

  Future<List<ServiceRM>> getAllServiceRequests({
    required double lat,
    required double long,
    required String mode,
    String? status,
  }) async {
    final url = urlBuilder.buildGetAllServiceRequestsUrl(
      lat: lat,
      long: long,
      mode: mode,
      status: status,
    );
    try {
      final response = await _dio.get(url);
      final serviceRequests = (response.data[_dataJsonKey] as List)
          .map((e) => ServiceRM.fromJson(e))
          .toList();
      return serviceRequests;
    } catch (_) {
      rethrow;
    }
  }

  Future acceptServiceRequest({
    required int serviceRequestId,
  }) async {
    final url = urlBuilder.buildAcceptServiceRequestUrl(
      serviceRequestId: serviceRequestId,
    );
    try {
      await _dio.post(url);
    } catch (_) {
      rethrow;
    }
  }

  Future fulfillServiceRequest({
    required int serviceRequestId,
    FulfillOtherServiceRM? fulfillOtherServiceRM,
    FulfillReservationServiceRM? fulfillReservationServiceRM,
  }) async {
    assert(fulfillOtherServiceRM != null || fulfillReservationServiceRM != null,
        'fulfillOtherServiceRM or fulfillReservationServiceRM must not be null');
    final url = urlBuilder.buildSubmitServiceRequestUrl(
      serviceRequestId: serviceRequestId,
    );
    final requestJsonBody = fulfillOtherServiceRM != null
        ? fulfillOtherServiceRM.toJson()
        : fulfillReservationServiceRM!.toJson();

    final formData = diox.FormData.fromMap({
      'location': (requestJsonBody['location'] as LocationRM).toJson(),
      'details': fulfillOtherServiceRM != null
          ? (requestJsonBody['details'] as FulfillOtherServiceDetailsRM)
              .toJson()
          : (requestJsonBody['details'] as FulfillReservationServiceDetailsRM)
              .toJson(),
    }, ListFormat.multiCompatible);

    try {
      final response = await _dio.post(
        url,
        data: formData,
      );
      debugPrint(response.data.toString());
    } catch (_) {
      rethrow;
    }
  }

  Future<ServiceRM> getServiceRequest({
    required int requestId,
  }) async {
    final url = urlBuilder.buildGetServiceRequestUrl(
      serviceRequestId: requestId,
    );
    try {
      final response = await _dio.get(url);
      final serviceRequest = ServiceRM.fromJson(response.data[_dataJsonKey]);
      return serviceRequest;
    } catch (_) {
      rethrow;
    }
  }

  Future confirmServiceRequest({
    required int serviceRequestId,
  }) async {
    final url = urlBuilder.buildConfirmServiceRequestUrl(
      serviceRequestId: serviceRequestId,
    );
    try {
      await _dio.post(url);
    } catch (_) {
      rethrow;
    }
  }

  Future cancelServiceRequest({
    required int serviceRequestId,
  }) async {
    final url = urlBuilder.buildCancelServiceRequestUrl(
      serviceRequestId: serviceRequestId,
    );
    try {
      await _dio.post(url);
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
          if (isCustomerUnAuth) {
            isUserUnAuthSC.value = (true);
            isUserUnAuthSC.value = (false);
          }
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
