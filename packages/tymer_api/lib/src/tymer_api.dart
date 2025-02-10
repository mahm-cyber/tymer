import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as diox;
import 'package:flutter/foundation.dart';
import 'package:tymer_api/src/auth_api.dart';
import 'package:tymer_api/src/dispute_api.dart';
import 'package:tymer_api/src/pusher_api.dart';
import 'package:tymer_api/src/service_api.dart';
import 'package:tymer_api/src/settings_api.dart';
import 'package:tymer_api/src/support_chat_api.dart';
import 'package:tymer_api/src/wallet_api.dart';
import 'package:tymer_api/tymer_api.dart';

typedef UserTokenSupplier = Future<String?> Function();

class TymerApi {
  TymerApi({
    required UserTokenSupplier userTokenSupplier,
    required this.unAuthenticatedAccessVN,
    required this.internetConnectionErrorVN,
    required this.dio,
    required this.urlBuilder,
  })  : auth = AuthApi(dio, urlBuilder),
        pusher = PusherApi(userTokenSupplier),
        settings = SettingsApi(dio, urlBuilder),
        service = ServiceApi(dio, urlBuilder),
        dispute = DisputeApi(dio, urlBuilder),
        supportChat = SupportChatApi(dio, urlBuilder),
        wallet = WalletApi(dio, urlBuilder) {
    dio.setUpAuthHeaders(
      userTokenSupplier: userTokenSupplier,
      unAuthenticatedAccessVN: unAuthenticatedAccessVN,
      internetConnectionErrorVN: internetConnectionErrorVN,
    );
    dio.interceptors.add(
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

  final Dio dio;
  final ValueNotifier<bool> unAuthenticatedAccessVN;
  final ValueNotifier<InternetConnectionTymerException?>
      internetConnectionErrorVN;
  final UrlBuilder urlBuilder;
  final PusherApi pusher;
  final AuthApi auth;
  final SettingsApi settings;
  final ServiceApi service;
  final DisputeApi dispute;
  final SupportChatApi supportChat;
  final WalletApi wallet;
}

extension on Dio {
  void setUpAuthHeaders({
    required UserTokenSupplier userTokenSupplier,
    required ValueNotifier<bool> unAuthenticatedAccessVN,
    required ValueNotifier<InternetConnectionTymerException?>
        internetConnectionErrorVN,
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
          options.headers.addAll({
            "Accept": "application/json",
            if (token != null) "Authorization": "Bearer $token",
            "X-API-Key": const String.fromEnvironment('x-api-key'),
          });
          return handler.next(options);
        },
        onError: (error, handler) {
          final isCustomerUnAuth = error.response?.statusCode == 401;
          final internetConnectionError =
              error.type == DioExceptionType.connectionError;
          if (isCustomerUnAuth) {
            unAuthenticatedAccessVN.value = (true);
            unAuthenticatedAccessVN.value = (false);
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
