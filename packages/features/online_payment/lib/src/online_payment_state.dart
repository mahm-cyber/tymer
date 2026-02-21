part of 'online_payment_cubit.dart';

enum OnlinePaymentStatus { initial, loading, success, failure }

class OnlinePaymentState extends Equatable {
  const OnlinePaymentState({
    this.status = OnlinePaymentStatus.initial,
    this.errorMessage,
    this.error,
  });

  final OnlinePaymentStatus status;
  final String? errorMessage;
  final dynamic error;

  OnlinePaymentState copyWith({
    OnlinePaymentStatus? status,
    String? errorMessage,
    dynamic error,
  }) {
    return OnlinePaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, error];
}
