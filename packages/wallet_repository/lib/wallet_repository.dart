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

  Future<PaymentMethods> getPaymentMethods() async {
    final paymentMethods = await remoteApi.getPaymentMethods();
    final paymentMethodsDomain = paymentMethods.toDomainModel();
    return paymentMethodsDomain;
  }

  Future<void> confirmTopUp({
    required PaymentMethodType paymentMethodType,
    required int amount,
    String? walletNumber,
    String? instantPaymentAddress,
    required File image,
  }) async {
    final paymentMethodTypeString = paymentMethodType.toRemoteModel();

    try {
      await remoteApi.confirmTopUp(
        paymentMethodType: paymentMethodTypeString,
        amount: amount,
        walletNumber: walletNumber,
        instantPaymentAddress: instantPaymentAddress,
        image: image.readAsBytesSync(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<String> confirmBankCardTopUp(int amount) async {
    try {
      final url = await remoteApi.confirmBankCardTopUp(amount);
      return url;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> confirmWithdraw({
    required PaymentMethodType paymentMethodType,
    required int amount,
    String? walletNumber,
    String? instantPaymentAddress,
    String? ibanNumber,
    String? beneficiaryName,
  }) async {
    final paymentMethodTypeString = paymentMethodType.toRemoteModel();

    try {
      await remoteApi.confirmWithdraw(
        paymentMethodType: paymentMethodTypeString,
        amount: amount,
        walletNumber: walletNumber,
        instantPaymentAddress: instantPaymentAddress,
        ibanNumber: ibanNumber,
        beneficiaryName: beneficiaryName,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<PaymentListPage> getPayments({
    required PaymentType type,
    required PaymentMethodType paymentMethodType,
    required int page,
  }) async {
    try {
      final paymentListPageRM = await remoteApi.getPayments(
        type: type.toRemoteModel(),
        paymentMethodType: paymentMethodType.toRemoteModel(),
        page: page,
      );
      return paymentListPageRM.toDomainModel();
    } catch (e) {
      rethrow;
    }
  }

  Future<InAppTransactionListPage> getInAppTransactions({
    required int page,
  }) async {
    try {
      final inAppTransactionListPageRM =
          await remoteApi.getInAppTransactions(page: page);
      return inAppTransactionListPageRM.toDomainModel();
    } catch (e) {
      rethrow;
    }
  }
}
