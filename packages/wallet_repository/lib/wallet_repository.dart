import 'dart:io';

import 'package:wallet_repository/src/mappers/domain_to_remote.dart';
import 'package:wallet_repository/src/mappers/mappers.dart';
import 'package:wallet_repository/src/wallet_change_notifier.dart';

export 'src/mappers/remote_to_domain.dart';

class WalletRepository {
  WalletRepository({
    required this.remoteApi,
  }) : changeNotifier = WalletChangeNotifier();

  final TymerApi remoteApi;
  final WalletChangeNotifier changeNotifier;

  Future<PaymentMethods> getPaymentMethods(TransactionType paymentType) async {
    final paymentMethods =
        await remoteApi.wallet.getPaymentMethods(paymentType.toRemoteModel());
    final paymentMethodsDomain = paymentMethods.toDomainModel();
    return paymentMethodsDomain;
  }

  Future<void> confirmTopUp({
    required PaymentMethodType paymentMethodType,
    required double amount,
    String? walletNumber,
    String? instantPaymentAddress,
    String? teldaUsername,
    required File image,
  }) async {
    final paymentMethodTypeString = paymentMethodType.toRemoteModel();

    try {
      await remoteApi.wallet.confirmTopUp(
        paymentMethodType: paymentMethodTypeString,
        amount: amount,
        walletNumber: walletNumber,
        instantPaymentAddress: instantPaymentAddress,
        teldaUsername: teldaUsername,
        image: image.readAsBytesSync(),
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
