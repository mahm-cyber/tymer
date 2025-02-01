import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as diox;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:tymer_api/src/pusher_api.dart';
import 'package:tymer_api/tymer_api.dart';

typedef UserTokenSupplier = Future<String?> Function();

class TymerApi {
  static const _errorJsonKey = 'error';
  static const _dataJsonKey = 'data';
  static const _idJsonKey = 'id';
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
  static const _paymentLinkJsonKey = 'payment_link';
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

  Future<String> requestOtpForSignUp({
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
    final url = urlBuilder.buildReSendOtpUrl();

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

  Future requestOtpForChangePhone({
    required String phone,
    required String password,
  }) async {
    final url = urlBuilder.buildChangePhoneUrl();

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
    final url = urlBuilder.buildChangeLanguageUrl();

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
    final url = urlBuilder.buildVerifyOtpForChangePhoneUrl();

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
      return requestId;
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];
      final errorCode = errorObject[_codeJsonKey];
      if (errorCode.contains('INSUFFICIENT_BALANCE')) {
        throw InsufficientBalanceTymerException();
      }

      if (errorCode.contains(_validationErrorJsonKey) &&
          errorObject[_verificationErrorsJsonKey].containsKey('price')) {
        throw StaleMinimumPriceTymerException();
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

    final formData = diox.FormData.fromMap(
      {
        'location': (requestJsonBody['location'] as LocationRM).toJson(),
        'details': fulfillOtherServiceRM != null
            ? (requestJsonBody['details'] as FulfillOtherServiceDetailsRM)
                .toJson()
            : (requestJsonBody['details'] as FulfillReservationServiceDetailsRM)
                .toJson(),
      },
      ListFormat.multiCompatible,
    );

    try {
      await _dio.post(
        url,
        data: formData,
      );
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

  Future<DisputeRM> getDispute({
    required int disputeId,
    required String userType,
  }) async {
    final url = urlBuilder.buildGetDisputeUrl(
      disputeId: disputeId,
      userType: userType,
    );
    try {
      final response = await _dio.get(url);
      final dispute = DisputeRM.fromJson(response.data[_dataJsonKey]);
      return dispute;
    } catch (_) {
      rethrow;
    }
  }

  Future<int> disputeRequest({
    required int serviceRequestId,
    required String reason,
  }) async {
    final url = urlBuilder.buildDisputeRequestUrl(
      serviceRequestId: serviceRequestId,
    );
    try {
      final response = await _dio.post(
        url,
        data: {
          'other_details': reason,
        },
      );
      final disputeId = response.data[_dataJsonKey][_idJsonKey] as int;
      return disputeId;
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

  Future sendChatMessage({
    required int disputeId,
    required String userType,
    String? message,
    List<File?>? documentFiles,
    List<File?>? imageFiles,
    List<File?>? audioFiles,
  }) async {
    final url = urlBuilder.buildSendChatMessageUrl(
      disputeId: disputeId,
      userType: userType,
    );
    List<MultipartFile> documentMultipartFiles = [];
    List<MultipartFile> imageMultipartFiles = [];
    List<MultipartFile> audioMultipartFiles = [];
    if (documentFiles != null) {
      for (final documentFile in documentFiles) {
        if (documentFile != null) {
          final multipartFile = await MultipartFile.fromFile(
            documentFile.path,
            filename: documentFile.path.split('/').last,
          );
          documentMultipartFiles.add(multipartFile);
        }
      }
    }
    if (imageFiles != null) {
      for (final imageFile in imageFiles) {
        if (imageFile != null) {
          final multipartFile = await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          );
          imageMultipartFiles.add(multipartFile);
        }
      }
    }
    if (audioFiles != null) {
      for (final audioFile in audioFiles) {
        if (audioFile != null) {
          final multipartFile = await MultipartFile.fromFile(
            audioFile.path,
            filename: audioFile.path.split('/').last,
          );
          audioMultipartFiles.add(multipartFile);
        }
      }
    }

    final requestJsonBody = {
      if (imageFiles != null)
        for (var i = 0; i < imageMultipartFiles.length; i++)
          'chat_images[]': imageMultipartFiles[i],
      if (documentFiles != null)
        for (var i = 0; i < documentMultipartFiles.length; i++)
          'chat_documents[]': documentMultipartFiles[i],
      if (audioFiles != null)
        for (var i = 0; i < audioMultipartFiles.length; i++)
          'chat_records[]': audioMultipartFiles[i],
      'content': message,
    };

    final formData = FormData.fromMap(
      requestJsonBody,
      ListFormat.multiCompatible,
    );
    try {
      await _dio.post(
        url,
        data: formData,
      );
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

  Future<TermsAndConditionsRM> getTermsAndConditions() async {
    final url = urlBuilder.buildGetTermsAndConditionsUrl();
    try {
      final response = await _dio.get(url);
      final termsAndConditions = TermsAndConditionsRM.fromJson(
          response.data[_dataJsonKey][_contentJsonKey]);
      return termsAndConditions;
    } catch (error) {
      rethrow;
    }
  }

  Future<PrivacyPolicyRM> getPrivacyPolicy() async {
    final url = urlBuilder.buildGetPrivacyPolicyUrl();
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
    final url = urlBuilder.buildChangePasswordUrl();
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

  Future<PaymentMethodsRM> getPaymentMethods() async {
    final url = urlBuilder.buildGetPaymentMethodsUrl();
    try {
      final response = await _dio.get(url);
      final paymentMethods =
          PaymentMethodsRM.fromJson(response.data[_dataJsonKey]);
      return paymentMethods;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> confirmTopUp({
    required String paymentMethodType,
    required int amount,
    String? walletNumber,
    String? instantPaymentAddress,
    required List<int> image,
  }) async {
    final url = urlBuilder.buildConfirmTopUpUrl(paymentMethodType);
    final formData = FormData.fromMap(
      {
        'amount': amount.toStringAsFixed(2),
        if (walletNumber != null) 'wallet_number': walletNumber,
        if (instantPaymentAddress != null)
          'instant_payment_address': instantPaymentAddress,
        'proof': diox.MultipartFile.fromBytes(
          image,
          filename:
              'top_up_image${DateTime.now().toString().split(" ").join("")}.jpg',
        ),
      },
    );
    try {
      final response = await _dio.post(
        url,
        data: formData,
      );
      debugPrint(response.data.toString());
    } catch (error) {
      rethrow;
    }
  }

  Future<String> confirmBankCardTopUp(int amount) async {
    final url = urlBuilder.buildConfirmBankCardTopUpUrl();
    try {
      final response = await _dio.post(
        url,
        data: {
          'amount': amount,
        },
      );
      return response.data[_paymentLinkJsonKey] as String;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> sendFcmToken(String fcmToken) async {
    final url = urlBuilder.buildSendFcmTokenUrl();
    await _dio.post(
      url,
      data: {
        'fcm_token': fcmToken,
      },
    );
  }

  Future<void> confirmWithdraw({
    required String paymentMethodType,
    required int amount,
    String? walletNumber,
    String? instantPaymentAddress,
    String? ibanNumber,
    String? beneficiaryName,
  }) async {
    final url = urlBuilder.buildConfirmWalletWithdrawUrl(paymentMethodType);

    final requestJsonBody = <String, dynamic>{
      'amount': amount.toStringAsFixed(2),
      if (walletNumber != null) 'wallet_number': walletNumber,
      if (instantPaymentAddress != null)
        'instant_payment_address': instantPaymentAddress,
      if (ibanNumber != null) 'iban_number': ibanNumber,
      if (beneficiaryName != null) 'beneficiary_name': beneficiaryName,
    };

    try {
      final response = await _dio.post(
        url,
        data: requestJsonBody,
      );
      debugPrint('------- ${response.data}');
    } catch (e) {
      rethrow;
    }
  }

  Future<PaymentListPageRM> getPayments({
    required String type,
    required String paymentMethodType,
    required int page,
  }) async {
    final url = urlBuilder.buildGetPaymentsUrl(
      type: type,
      paymentMethodType: paymentMethodType,
      page: page,
    );

    try {
      final response = await _dio.get(url);
      final paymentListPage = PaymentListPageRM.fromJson(response.data);
              final currentPage = response.data['meta']['current_page'] as int;
      final lastPage = response.data['meta']['last_page'] as int;
      final isLastPage = currentPage >= lastPage;
      paymentListPage.isLastPage = isLastPage;
      return paymentListPage;
    } catch (e) {
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
              // if (token != null) "Authorization": "Bearer 213|kjjsOyXpt2rxcZkVgnMJGmAOD26r0uIolCJqn8YNd4065eds",
              if (token != null) "Authorization": "Bearer $token",
              "X-API-Key": const String.fromEnvironment('x-api-key'),
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
