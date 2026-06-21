import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as diox;
import 'package:flutter/foundation.dart';
import 'package:tymer_api/tymer_api.dart';

typedef UserTokenSupplier = Future<String?> Function();

class WalletApi {
  static const _errorJsonKey = 'error';
  static const _dataJsonKey = 'data';
  static const _codeJsonKey = 'code';
  static const _paymentLinkJsonKey = 'payment_link';
  static const _messageJsonKey = 'message';
  static const _transactionIdJsonKey = 'transaction_id';
  static const _checkoutUrlJsonKey = 'checkout_url';

  WalletApi(
    this._dio,
    this._urlBuilder,
  );

  final Dio _dio;

  final UrlBuilder _urlBuilder;

  Future<PaymentMethodsRM> getPaymentMethods(String paymentType) async {
    final url = _urlBuilder.buildGetPaymentMethodsUrl(paymentType);
    try {
      final response = await _dio.get(url);
      final paymentMethods =
          PaymentMethodsRM.fromJson(response.data[_dataJsonKey]);
      return paymentMethods;
    } catch (error) {
      rethrow;
    }
  }

  Future<TransactionListPageRM> getAllTransactions({required int page}) async {
    final url = _urlBuilder.buildGetInAppTransactionsUrl(page: page);
    try {
      final response = await _dio.get(url);
      final transactions = TransactionListPageRM.fromJson(response.data);
      final currentPage = response.data['meta']['current_page'] as int;
      final lastPage = response.data['meta']['last_page'] as int;
      final isLastPage = currentPage >= lastPage;
      transactions.isLastPage = isLastPage;
      return transactions;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> confirmTopUp({
    required String paymentMethodType,
    required double amount,
    String? walletNumber,
    String? instantPaymentAddress,
    String? teldaUsername,
    String? ibanNumber,
    String? beneficiaryName,
    List<int>? image,
    String? transactionId,
  }) async {
    final url = _urlBuilder.buildConfirmTopUpUrl(paymentMethodType);
    final formData = FormData.fromMap({
      'amount': amount.toStringAsFixed(2),
      if (walletNumber != null) 'wallet_number': walletNumber,
      if (instantPaymentAddress != null)
        'instant_payment_address': instantPaymentAddress,
      if (teldaUsername != null) 'telda_username': teldaUsername,
      if (transactionId != null) 'transaction_id': transactionId,
      if (image != null)
        'proof': diox.MultipartFile.fromBytes(
          image,
          filename:
              'top_up_image${DateTime.now().toString().split(" ").join("")}.jpg',
        ),
    });
    try {
      final response = await _dio.post(url, data: formData);
      debugPrint(response.data.toString());
    } catch (error) {
      rethrow;
    }
  }

  Future<String> confirmBankCardTopUp(double amount) async {
    final url = _urlBuilder.buildConfirmBankCardTopUpUrl();
    try {
      final response = await _dio.post(url, data: {'amount': amount});
      return response.data[_paymentLinkJsonKey] as String;
    } catch (error) {
      rethrow;
    }
  }

  /// Initiates a Paymob checkout top-up via the Tymer backend.
  ///
  /// [issuer] must be one of: `vodafone`, `etisalat`, `orange`.
  /// Returns a map with `checkout_url` and `transaction_id` on success.
  /// Throws [PaymobTopUpFailedTymerException] when the backend reports a
  /// payment-level failure (e.g. locked number, insufficient balance).
  Future<Map<String, String>> paymobTopUp({
    required String issuer,
    required int amount,
    required String msisdn,
  }) async {
    final url = _urlBuilder.buildPaymobTopUpUrl();
    try {
      final response = await _dio.post(url, data: {
        'issuer': issuer,
        'amount': amount,
        'msisdn': msisdn,
      });
      // The full response shape is:
      // { "success": true, "data": { "checkout_url": "...", "transaction_id": 91, ... }, ... }
      // checkout_url lives inside `data`, NOT at the response root.
      final rm = PaymobTopUpRM.fromJson(
        response.data as Map<String, dynamic>,
      );
      return {
        _checkoutUrlJsonKey: rm.data.checkoutUrl,
        _transactionIdJsonKey: rm.data.transactionId.toString(),
      };
    } on DioException catch (error) {
      final message = error.response?.data[_messageJsonKey] as String?;
      if (message != null) throw PaymobTopUpFailedTymerException(message);
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> confirmWithdraw({
    required String paymentMethodType,
    required double amount,
    String? walletNumber,
    String? instantPaymentAddress,
    String? ibanNumber,
    String? beneficiaryName,
    String? teldaUsername,
  }) async {
    final url = _urlBuilder.buildConfirmWalletWithdrawUrl(paymentMethodType);

    final requestJsonBody = <String, dynamic>{
      'amount': amount.toStringAsFixed(2),
      if (walletNumber != null) 'wallet_number': walletNumber,
      if (instantPaymentAddress != null)
        'instant_payment_address': instantPaymentAddress,
      if (ibanNumber != null) 'iban_number': ibanNumber,
      if (beneficiaryName != null) 'beneficiary_name': beneficiaryName,
      if (teldaUsername != null) 'telda_username': teldaUsername,
    };

    try {
      final response = await _dio.post(url, data: requestJsonBody);
      debugPrint('------- ${response.data}');
    } on DioException catch (error) {
      if (error.response?.statusCode == 402 &&
          error.response?.data[_errorJsonKey][_codeJsonKey] ==
              'INSUFFICIENT_BALANCE') {
        throw InsufficientBalanceTymerException();
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<PaymentListPageRM> getPayments({
    required String type,
    required String paymentMethodType,
    required int page,
  }) async {
    final url = _urlBuilder.buildGetPaymentsUrl(
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
