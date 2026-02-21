import 'dart:convert';

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

  /// Called once the JS has resolved `document.body.innerText`.
  /// Parses the JSON body and emits success or failure accordingly.
  void onJsBodyResolved(String? rawBody) {
    if (rawBody == null || rawBody.isEmpty) return;

    try {
      // The body may be a JSON string or a JSON-encoded string containing JSON.
      dynamic decoded = jsonDecode(rawBody);
      final Map<String, dynamic> json =
          decoded is Map<String, dynamic> ? decoded : jsonDecode(decoded);

      final status = json['status'];
      if (status == 1) {
        emit(state.copyWith(status: OnlinePaymentStatus.success));
        onPaymentSuccess();
      } else {
        final message = json['message'] as String?;
        emit(state.copyWith(
          status: OnlinePaymentStatus.failure,
          errorMessage: message,
        ));
        onPaymentFailure();
      }
    } catch (e) {
      // Body is not parseable JSON — the page is still loading content.
      // Silently ignore; we only act on payment-result pages.
    }
  }
}
