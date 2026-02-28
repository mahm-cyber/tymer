import 'dart:async';

import 'package:dio/dio.dart';
import 'package:paymob_api/src/models/paymob_budget_rm.dart';
import 'package:paymob_api/src/models/paymob_disburse_response_rm.dart';
import 'package:paymob_api/src/models/paymob_exceptions.dart';
import 'package:paymob_api/src/models/paymob_token_rm.dart';
import 'package:paymob_api/src/models/paymob_transaction_status_rm.dart';
import 'package:paymob_api/src/paymob_url_builder.dart';

/// Supported mobile wallet issuers for Paymob disbursements.
enum PaymobWalletIssuer {
  vodafone,
  etisalat,
  orange,
  bankWallet;

  /// Returns the string value expected by the Paymob API.
  String toApiValue() {
    switch (this) {
      case PaymobWalletIssuer.vodafone:
        return 'vodafone';
      case PaymobWalletIssuer.etisalat:
        return 'etisalat';
      case PaymobWalletIssuer.orange:
        return 'orange';
      case PaymobWalletIssuer.bankWallet:
        return 'bank_wallet';
    }
  }
}

/// API client for the Paymob Payout portal.
///
/// Handles OAuth2 token lifecycle (generate + in-memory caching) and exposes
/// methods for all available Paymob Payout endpoints:
///  - [disburseToWallet] – instant mobile-wallet disbursement
///  - [inquireTransactions] – bulk transaction status inquiry
///  - [inquireBudget] – current balance inquiry
///  - [cancelAmanTransaction] – cancel a pending Aman transaction
///
/// Credentials are read from `--dart-define` values at compile time:
///   PAYMOB_CLIENT_ID, PAYMOB_CLIENT_SECRET, PAYMOB_USERNAME, PAYMOB_PASSWORD
class PaymobPayoutApi {
  PaymobPayoutApi({
    Dio? dio,
    PaymobUrlBuilder? urlBuilder,
  })  : _dio = dio ?? Dio(),
        _urlBuilder = urlBuilder ?? PaymobUrlBuilder() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
  }

  // ── Compile-time credentials (via --dart-define) ──────────────────────────

  static const _clientId = String.fromEnvironment('PAYMOB_CLIENT_ID');
  static const _clientSecret = String.fromEnvironment('PAYMOB_CLIENT_SECRET');
  static const _username = String.fromEnvironment('PAYMOB_USERNAME');
  static const _password = String.fromEnvironment('PAYMOB_PASSWORD');

  // ── JSON keys ─────────────────────────────────────────────────────────────

  static const _issuerKey = 'issuer';
  static const _amountKey = 'amount';
  static const _msisdnKey = 'msisdn';
  static const _transactionIdsKey = 'transactions_ids_list';
  static const _transactionIdKey = 'transaction_id';

  // ── Internals ─────────────────────────────────────────────────────────────

  final Dio _dio;
  final PaymobUrlBuilder _urlBuilder;

  /// In-memory access token cache.
  String? _accessToken;

  /// Absolute time at which [_accessToken] expires.
  DateTime? _tokenExpiry;

  // ── Token Management ──────────────────────────────────────────────────────

  /// Returns a valid Bearer token, generating a new one if needed.
  Future<String> _getValidToken() async {
    final now = DateTime.now();
    if (_accessToken != null &&
        _tokenExpiry != null &&
        now.isBefore(_tokenExpiry!.subtract(const Duration(seconds: 30)))) {
      return _accessToken!;
    }
    return _generateToken();
  }

  /// Generates a new OAuth2 token using the password grant.
  Future<String> _generateToken() async {
    final url = _urlBuilder.buildTokenUrl();
    try {
      final response = await _dio.post(
        url,
        data: {
          'client_id': _clientId,
          'client_secret': _clientSecret,
          'username': _username,
          'password': _password,
          'grant_type': 'password',
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      final tokenRM = PaymobTokenRM.fromJson(
        response.data as Map<String, dynamic>,
      );
      _accessToken = tokenRM.accessToken;
      _tokenExpiry = DateTime.now().add(
        Duration(seconds: tokenRM.expiresIn),
      );
      return tokenRM.accessToken;
    } on DioException catch (e) {
      throw PaymobAuthFailedTymerException(
        e.response?.data?.toString() ?? e.message,
      );
    }
  }

  // ── Default authorized options ─────────────────────────────────────────────

  Future<Options> _authorizedOptions() async {
    final token = await _getValidToken();
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  // ── Public API Methods ─────────────────────────────────────────────────────

  /// Disburse funds instantly to a mobile wallet.
  ///
  /// [issuer] – the wallet provider (vodafone, etisalat, orange, bank_wallet)
  /// [amount] – amount as a string with decimal, e.g. "100.0"
  /// [msisdn] – recipient's phone number, e.g. "01092737975"
  ///
  /// Throws [PaymobDisburseFailedTymerException] on failure.
  Future<PaymobDisburseResponseRM> disburseToWallet({
    required PaymobWalletIssuer issuer,
    required double amount,
    required String msisdn,
  }) async {
    final url = _urlBuilder.buildDisburseUrl();
    final options = await _authorizedOptions();
    try {
      final response = await _dio.post(
        url,
        data: {
          _issuerKey: issuer.toApiValue(),
          _amountKey: amount.toStringAsFixed(2),
          _msisdnKey: msisdn,
        },
        options: options,
      );
      return PaymobDisburseResponseRM.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;
      // Insufficient budget typically returns 400 or 402
      if (statusCode == 400 || statusCode == 402) {
        final detail = responseData?.toString().toLowerCase() ?? '';
        if (detail.contains('budget') || detail.contains('balance')) {
          throw const PaymobInsufficientBudgetTymerException();
        }
      }
      throw PaymobDisburseFailedTymerException(
        responseData?.toString() ?? e.message,
      );
    }
  }

  /// Inquire about the status of one or more transactions by their IDs.
  ///
  /// Returns a list of [PaymobTransactionStatusRM] objects.
  /// Throws [PaymobTransactionInquiryFailedTymerException] on failure.
  Future<List<PaymobTransactionStatusRM>> inquireTransactions(
    List<String> transactionIds,
  ) async {
    final url = _urlBuilder.buildTransactionInquiryUrl();
    final options = await _authorizedOptions();
    try {
      final response = await _dio.post(
        url,
        data: {_transactionIdsKey: transactionIds},
        options: options,
      );
      final data = response.data;
      if (data is List) {
        return data
            .map((item) => PaymobTransactionStatusRM.fromJson(
                item as Map<String, dynamic>))
            .toList();
      }
      // If the server wraps the list in an object
      if (data is Map<String, dynamic>) {
        final list =
            data['data'] as List? ?? data['transactions'] as List? ?? [];
        return list
            .map((item) => PaymobTransactionStatusRM.fromJson(
                item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      throw PaymobTransactionInquiryFailedTymerException(
        e.response?.data?.toString() ?? e.message,
      );
    }
  }

  /// Inquire about the current available budget (balance) for the API user.
  ///
  /// Throws [PaymobAuthFailedTymerException] if auth fails.
  Future<PaymobBudgetRM> inquireBudget() async {
    final url = _urlBuilder.buildBudgetInquiryUrl();
    final options = await _authorizedOptions();
    try {
      final response = await _dio.get(url, options: options);
      return PaymobBudgetRM.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw PaymobAuthFailedTymerException(
        e.response?.data?.toString() ?? e.message,
      );
    }
  }

  /// Cancel a pending Aman transaction by its ID.
  ///
  /// Throws [PaymobTransactionInquiryFailedTymerException] on failure.
  Future<void> cancelAmanTransaction(String transactionId) async {
    final url = _urlBuilder.buildCancelAmanUrl();
    final options = await _authorizedOptions();
    try {
      await _dio.post(
        url,
        data: {_transactionIdKey: transactionId},
        options: options,
      );
    } on DioException catch (e) {
      throw PaymobTransactionInquiryFailedTymerException(
        e.response?.data?.toString() ?? e.message,
      );
    }
  }

  /// Force-regenerate the OAuth2 token (useful for manual refresh or testing).
  Future<void> refreshToken() => _generateToken();
}
