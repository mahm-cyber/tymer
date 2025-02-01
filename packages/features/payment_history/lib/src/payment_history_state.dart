part of 'payment_history_cubit.dart';

class PaymentHistoryState extends Equatable {
  const PaymentHistoryState({
    this.payments,
    this.nextPage,
    this.nextListPageLoadError,
    this.paymentsFetchStatus = FetchStatus.initial,
    this.statusFilter = PaymentStatus.pending,
    this.paymentType,
    this.paymentMethodType = PaymentMethodType.vodafoneCash,
  });

  final List<Payment>? payments;
  final int? nextPage;
  final dynamic nextListPageLoadError;
  final FetchStatus paymentsFetchStatus;
  final PaymentStatus statusFilter;
  final PaymentType? paymentType;
  final PaymentMethodType? paymentMethodType;
  List<PaymentStatus> get paymentStatusFilters => [
        PaymentStatus.pending,
        PaymentStatus.approved,
        PaymentStatus.rejected,
      ];

  List<Payment>? get ascendingSortedPayments =>
      payments?..sort((b, a) => a.updatedAt.compareTo(b.updatedAt));

  PaymentHistoryState copyWith({
    List<Payment>? payments,
    int? nextPage,
    dynamic nextListPageLoadError,
    FetchStatus? paymentsFetchStatus,
    PaymentStatus? statusFilter,
    PaymentType? paymentType,
    PaymentMethodType? paymentMethodType,
  }) {
    return PaymentHistoryState(
      payments: payments ?? this.payments,
      nextPage: nextPage,
      nextListPageLoadError: nextListPageLoadError,
      paymentsFetchStatus: paymentsFetchStatus ?? this.paymentsFetchStatus,
      statusFilter: statusFilter ?? this.statusFilter,
      paymentType: paymentType ?? this.paymentType,
      paymentMethodType: paymentMethodType ?? this.paymentMethodType,
    );
  }

  @override
  List<Object?> get props => [
        payments,
        nextPage,
        nextListPageLoadError,
        paymentsFetchStatus,
        statusFilter,
        paymentType,
        paymentMethodType,
      ];
}

enum FetchStatus {
  initial,
  loading,
  success,
  failure,
} 