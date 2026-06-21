import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'online_payment_state.dart';

class OnlinePaymentCubit extends Cubit<OnlinePaymentState> {
  OnlinePaymentCubit({
    required this.onPaymentSuccess,
    required this.onPaymentFailure,
  }) : super(const OnlinePaymentState());

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
  /// Parses the `success` query parameter and emits [OnlinePaymentStatus.success]
  /// or [OnlinePaymentStatus.failure] accordingly.
  /// The caller must return [NavigationDecision.prevent] so the app never
  /// actually opens that URL.
  void onPaymentResultUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final success = uri.queryParameters['success'];
      if (success == 'true') {
        emit(state.copyWith(status: OnlinePaymentStatus.success));
        onPaymentSuccess();
      } else {
        final errorMessage = uri.queryParameters['data.message'];
        emit(state.copyWith(
          status: OnlinePaymentStatus.failure,
          errorMessage: errorMessage,
        ));
        onPaymentFailure();
      }
    } catch (_) {
      // Malformed URL — treat as failure.
      emit(state.copyWith(status: OnlinePaymentStatus.failure));
      onPaymentFailure();
    }
  }
}
