import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as diox;
import 'package:flutter/material.dart';
import 'package:tymer_api/src/pusher_api.dart';
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
  static const _messageJsonKey = 'message';

  TymerApi({
    required UserTokenSupplier userTokenSupplier,
    required this.isUserUnAuthSC,
    required this.internetConnectionErrorVN,
  })  : urlBuilder = UrlBuilder(),
        pusherApi = PusherApi(userTokenSupplier),
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
  final PusherApi pusherApi;

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
    final requestJsonBodyWithRemember = {
      ...requestJsonBody,
      'remember': true,
    };
    try {
      final response = await _dio.post(
        url,
        data: requestJsonBodyWithRemember,
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

  Future forgotPassword({
    required String phone,
  }) async {
    final url = urlBuilder.buildForgotPasswordUrl();

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
    final url = urlBuilder.buildResetPasswordUrl();

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
      if (errorObject[_codeJsonKey]
          .contains('PHONE_NUMBER_VERIFICATION_OTP_MISMATCH')) {
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

  Future<ServiceListPageRM> getAllServiceRequests({
    int? page,
    required double lat,
    required double long,
    required String userType,
    String? status,
  }) async {
    final url = urlBuilder.buildGetAllServiceRequestsUrl(
      page: page,
      lat: lat,
      long: long,
      userType: userType,
      status: status,
    );
    try {
      final response = await _dio.get(url);
      final serviceRequests = ServiceListPageRM.fromJson(response.data);
      final hasPagination = response.data['meta'] != null;
      if (hasPagination) {
        final currentPage = response.data['meta']['current_page'] as int;
        final lastPage = response.data['meta']['last_page'] as int;
        final isLastPage = currentPage >= lastPage;
        serviceRequests.isLastPage = isLastPage;
      }
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
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey][_codeJsonKey];
      if (errorObject.contains('SERVICE_REQUEST_ALREADY_PROCESSED')) {
        throw ServiceRequestAlreadyProcessedTymerException();
      }
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

  Future disputeRequest({
    required int serviceRequestId,
    required String reason,
  }) async {
    final url = urlBuilder.buildDisputeRequestUrl(
      serviceRequestId: serviceRequestId,
    );
    try {
      await _dio.post(
        url,
        data: {
          'other_details': reason,
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<DisputeListPageRM> getAllDisputes({
    required int page,
    required String userType,
    String? status,
  }) async {
    final url = urlBuilder.buildGetAllDisputesUrl(
      page: page,
      userType: userType,
      status: status,
    );
    try {
      final response = await _dio.get(url);
      final disputes = DisputeListPageRM.fromJson(response.data);
      final currentPage = response.data['meta']['current_page'] as int;
      final lastPage = response.data['meta']['last_page'] as int;
      final isLastPage = currentPage >= lastPage;
      disputes.isLastPage = isLastPage;
      return disputes;
    } catch (_) {
      rethrow;
    }
  }

  Future<DisputeChatRM> getDisputeChat({
    required int disputeId,
    required String userType,
  }) async {
    final url = urlBuilder.buildGetDisputeChatUrl(
      disputeId: disputeId,
      userType: userType,
    );
    try {
      final response = await _dio.get(url);
      final disputeChat = DisputeChatRM.fromJson(response.data);
      return disputeChat;
    } catch (_) {
      rethrow;
    }
  }

  Future<PricingSettingsRM> getPricingSettings() async {
    final url = urlBuilder.buildGetPricingSettingsUrl();
    try {
      final response = await _dio.get(url);
      final pricingSettings =
          PricingSettingsRM.fromJson(response.data[_dataJsonKey]);
      return pricingSettings;
    } catch (error) {
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
          // debugPrint('requestToken: $token');
          options.headers.addAll(
            {
              "Accept": "application/json",
              // if (token != null) "Authorization": "Bearer 213|kjjsOyXpt2rxcZkVgnMJGmAOD26r0uIolCJqn8YNd4065eds",
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
