import 'dart:io';

import 'package:wallet_repository/src/mappers/domain_to_remote.dart';
import 'package:wallet_repository/src/mappers/mappers.dart';
import 'package:wallet_repository/src/wallet_change_notifier.dart';
import 'package:wallet_repository/src/wallet_secure_storage.dart';

export 'src/mappers/remote_to_domain.dart';

class WalletRepository {
  WalletRepository({
    required this.remoteApi,
    WalletSecureStorage? secureStorage,
  })  : changeNotifier = WalletChangeNotifier(),
        _secureStorage = secureStorage ?? const WalletSecureStorage() {
    _initializePendingSyncs();
  }

  final TymerApi remoteApi;
  final WalletChangeNotifier changeNotifier;
  final WalletSecureStorage _secureStorage;

  void _initializePendingSyncs() async {
    final pending = await _secureStorage.getPendingTransactions();
    final now = DateTime.now().millisecondsSinceEpoch;
    for (final item in pending) {
      final id = item['id'] as String;
      final createdAt = item['createdAt'] as int;
      final elapsedSeconds = (now - createdAt) ~/ 1000;
      final delaySeconds = 60*6 - elapsedSeconds;
      _scheduleSync(id, delaySeconds > 0 ? delaySeconds : 0);
    }
  }

  void checkAndSyncPendingTransactions() {
    _initializePendingSyncs();
  }


  void _scheduleSync(String transactionId, int delaySeconds) {
    Future.delayed(Duration(seconds: delaySeconds), () async {
      try {
        await syncPaymobTopUp(transactionId);
        // Trigger transactions list and balance refresh
        changeNotifier.triggerRefreshTransactions();
        // If it is completed or failed (not pending anymore), remove it from secure storage.
        // We also remove it if it fails to sync after 10 minutes to avoid repeating forever.
        await _secureStorage.removePendingTransaction(transactionId);
      } catch (_) {

        // If there was an error (e.g. network issue), we keep it in secure storage so it retries on next app launch.
      }
    });
  }

  Future<PaymentMethods> getPaymentMethods(TransactionType paymentType) async {
    try {
      final paymentMethods =
          await remoteApi.wallet.getPaymentMethods(paymentType.toRemoteModel());
      final paymentMethodsDomain = paymentMethods.toDomainModel();
      return paymentMethodsDomain;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> confirmTopUp({
    required PaymentMethodType paymentMethodType,
    required double amount,
    String? walletNumber,
    String? instantPaymentAddress,
    String? teldaUsername,
    File? image,
    String? transactionId,
  }) async {
    final paymentMethodTypeString = paymentMethodType.toRemoteModel();

    try {
      await remoteApi.wallet.confirmTopUp(
        paymentMethodType: paymentMethodTypeString,
        amount: amount,
        walletNumber: walletNumber,
        instantPaymentAddress: instantPaymentAddress,
        teldaUsername: teldaUsername,
        image: image?.readAsBytesSync(),
        transactionId: transactionId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> confirmBankCardTopUp(double amount) async {
    try {
      final url = await remoteApi.wallet.confirmBankCardTopUp(amount);
      return url;
    } catch (e) {
      rethrow;
    }
  }

  /// Calls the Tymer backend's /top-up/paymob endpoint for Vodafone, Etisalat
  /// or Orange wallet top-ups. Returns a [PaymobTopUpResult] containing the
  /// `checkoutUrl` to redirect the user to and the server `transactionId`.
  ///
  /// Throws [PaymobTopUpFailedException] when the payment gateway rejects the
  /// transaction (e.g. locked number).
  Future<PaymobTopUpResult> paymobTopUp({
    required PaymentMethodType paymentMethodType,
    required double amount,
    required String msisdn,
  }) async {
    final issuerMap = {
      PaymentMethodType.vodafoneCash: 'vodafone',
      PaymentMethodType.etisalatCash: 'etisalat',
      PaymentMethodType.orangeCash: 'orange',
    };

    final issuer = issuerMap[paymentMethodType];
    if (issuer == null) {
      throw UnsupportedError('Unsupported issuer type: $paymentMethodType');
    }

    try {
      final raw = await remoteApi.wallet.paymobTopUp(
        issuer: issuer,
        amount: amount,
        msisdn: msisdn,
      );
      final result = PaymobTopUpResult(
        checkoutUrl: raw['checkout_url']!,
        transactionId: raw['transaction_id']!,
      );
      
      // Store the pending transaction locally and schedule background verification
      _secureStorage.addPendingTransaction(result.transactionId).then((_) {
        _scheduleSync(result.transactionId, 600);
      });

      return result;
    } catch (e) {
      if (e is PaymobTopUpFailedTymerException) {
        throw PaymobTopUpFailedException(e.message);
      }
      rethrow;
    }
  }

  Future<PaymobSyncResult> syncPaymobTopUp(String transactionId) async {
    try {
      final raw = await remoteApi.wallet.paymobSync(transactionId: transactionId);
      return raw.toDomainModel();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> confirmWithdraw({
    required PaymentMethodType paymentMethodType,
    required double amount,
    String? walletNumber,
    String? instantPaymentAddress,
    String? ibanNumber,
    String? beneficiaryName,
    String? teldaUsername,
  }) async {
    final paymentMethodTypeString = paymentMethodType.toRemoteModel();

    try {
      await remoteApi.wallet.confirmWithdraw(
        paymentMethodType: paymentMethodTypeString,
        amount: amount,
        walletNumber: walletNumber,
        instantPaymentAddress: instantPaymentAddress,
        ibanNumber: ibanNumber,
        beneficiaryName: beneficiaryName,
        teldaUsername: teldaUsername,
      );
    } catch (e) {
      if (e is InsufficientBalanceTymerException) {
        throw InsufficientBalanceException();
      }
      rethrow;
    }
  }

  Future<PaymentListPage> getPayments({
    required TransactionType type,
    required PaymentMethodType paymentMethodType,
    required int page,
  }) async {
    try {
      final paymentListPageRM = await remoteApi.wallet.getPayments(
        type: type.toRemoteModel(),
        paymentMethodType: paymentMethodType.toRemoteModel(),
        page: page,
      );
      return paymentListPageRM.toDomainModel();
    } catch (e) {
      rethrow;
    }
  }

  Future<TransactionListPage> getAllTransactions({
    required int page,
  }) async {
    try {
      final transactionListPageRM =
          await remoteApi.wallet.getAllTransactions(page: page);
      return transactionListPageRM.toDomainModel();
    } catch (e) {
      rethrow;
    }
  }
}
