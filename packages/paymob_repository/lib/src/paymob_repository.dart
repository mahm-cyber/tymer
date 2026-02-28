import 'package:domain_models/domain_models.dart';
import 'package:paymob_api/paymob_api.dart';
import 'package:paymob_repository/src/models/paymob_disbursement.dart';

/// Repository that bridges the [PaymobPayoutApi] with the application layer.
///
/// Translates API-layer ([PaymobPayoutApi]) models and exceptions into domain
/// objects and exceptions from `domain_models`.
class PaymobRepository {
  const PaymobRepository({
    required PaymobPayoutApi paymobApi,
  }) : _paymobApi = paymobApi;

  final PaymobPayoutApi _paymobApi;

  /// Disburse funds to a mobile wallet.
  ///
  /// [issuer] – the wallet provider enum value
  /// [amount] – amount in EGP
  /// [msisdn] – recipient phone number (e.g. "01092737975")
  ///
  /// Throws:
  ///   - [PaymobDisbursementFailedException] if the disbursement is rejected
  ///   - [PaymobInsufficientBudgetException] if the account has insufficient funds
  Future<PaymobDisbursement> disburseToWallet({
    required PaymobWalletIssuer issuer,
    required double amount,
    required String msisdn,
  }) async {
    try {
      final responseRM = await _paymobApi.disburseToWallet(
        issuer: issuer,
        amount: amount,
        msisdn: msisdn,
      );
      return PaymobDisbursement(
        transactionId: responseRM.transactionId,
        status: responseRM.status,
        issuer: issuer.toApiValue(),
        amount: amount,
        msisdn: msisdn,
      );
    } on PaymobInsufficientBudgetTymerException {
      throw const PaymobInsufficientBudgetException();
    } on PaymobDisburseFailedTymerException catch (e) {
      throw PaymobDisbursementFailedException(e.message);
    }
  }

  /// Inquire about the current available balance.
  ///
  /// Throws [PaymobDisbursementFailedException] if the request fails.
  Future<PaymobBudget> getBudget() async {
    try {
      final budgetRM = await _paymobApi.inquireBudget();
      return PaymobBudget(
        availableBalance: budgetRM.availableBalance,
        currency: budgetRM.currency,
      );
    } on PaymobAuthFailedTymerException catch (e) {
      throw PaymobDisbursementFailedException(e.message);
    }
  }

  /// Inquire about the status of one or more disbursement transactions.
  Future<List<PaymobTransactionStatus>> getTransactionStatuses(
    List<String> transactionIds,
  ) async {
    try {
      final statusesRM = await _paymobApi.inquireTransactions(transactionIds);
      return statusesRM
          .map(
            (rm) => PaymobTransactionStatus(
              transactionId: rm.transactionId,
              status: rm.status,
              issuer: rm.issuer,
              amount: rm.amount,
              msisdn: rm.msisdn,
              createdAt: rm.createdAt,
            ),
          )
          .toList();
    } on PaymobTransactionInquiryFailedTymerException catch (e) {
      throw PaymobDisbursementFailedException(e.message);
    }
  }

  /// Cancel a pending Aman transaction.
  Future<void> cancelAmanTransaction(String transactionId) async {
    try {
      await _paymobApi.cancelAmanTransaction(transactionId);
    } on PaymobTransactionInquiryFailedTymerException catch (e) {
      throw PaymobDisbursementFailedException(e.message);
    }
  }
}
