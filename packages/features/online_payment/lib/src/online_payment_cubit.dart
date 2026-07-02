import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'online_payment_state.dart';

class OnlinePaymentCubit extends Cubit<OnlinePaymentState> {
  OnlinePaymentCubit({
    required WalletRepository walletRepository,
    required String transactionId,
    required this.onPaymentSuccess,
    required this.onPaymentFailure,
  })  : _walletRepository = walletRepository,
        _transactionId = transactionId,
        super(const OnlinePaymentState());

  final WalletRepository _walletRepository;
  final String _transactionId;
  final VoidCallback onPaymentSuccess;
  final VoidCallback onPaymentFailure;

  void onPageStarted() {
    emit(state.copyWith(status: OnlinePaymentStatus.loading));
  }

  void onPageFinished() {
    emit(state.copyWith(status: OnlinePaymentStatus.initial));
  }

  /// Called when the WebView is about to navigate to the Paymob `post_pay`
  /// redirect URL (e.g. `.../post_pay?success=true&...`).
  ///
  /// Intercepts the redirect, checks and syncs the status with the backend,
  /// and updates the UI state accordingly.
  void onPaymentResultUrl(String url) async {
    emit(state.copyWith(status: OnlinePaymentStatus.loading));
    try {
      final syncResult = await _walletRepository.syncPaymobTopUp(_transactionId);
      if (syncResult.isSuccess || syncResult.isPending) {
        emit(state.copyWith(
          status: OnlinePaymentStatus.success,
          successMessage: syncResult.message,
        ));
        onPaymentSuccess();
      } else {
        emit(state.copyWith(
          status: OnlinePaymentStatus.failure,
          errorMessage: syncResult.message,
        ));
        onPaymentFailure();
      }
    } catch (e) {
      // Treat exception as failure.
      emit(state.copyWith(
        status: OnlinePaymentStatus.failure,
        error: e,
      ));
      onPaymentFailure();
    }
  }

}

