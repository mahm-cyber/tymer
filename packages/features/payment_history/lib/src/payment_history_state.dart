part of 'payment_history_cubit.dart';

class PaymentHistoryState extends Equatable {
  const PaymentHistoryState({
    this.userToken,
    this.payments,
    this.nextPage,
    this.nextListPageLoadError,
    this.paymentsFetchStatus = FetchStatus.initial,
    this.statusFilter = PaymentStatus.pending,
    this.paymentType,
    this.paymentMethodType = PaymentMethodType.vodafoneCash,
  });

  final String? userToken;
  final List<Payment>? payments;
  final int? nextPage;
  final dynamic nextListPageLoadError;
  final FetchStatus paymentsFetchStatus;
  final PaymentStatus statusFilter;
  final TransactionType? paymentType;
  final PaymentMethodType? paymentMethodType;
  List<PaymentStatus> get paymentStatusFilters => [
        PaymentStatus.pending,
        PaymentStatus.approved,
        PaymentStatus.rejected,
      ];

  List<Payment>? get ascendingSortedPayments =>
      payments?..sort((b, a) => a.updatedAt.compareTo(b.updatedAt));

  PaymentHistoryState copyWith({
    String? userToken,
    List<Payment>? payments,
    int? nextPage,
    dynamic nextListPageLoadError,
    FetchStatus? paymentsFetchStatus,
    PaymentStatus? statusFilter,
    TransactionType? paymentType,
    PaymentMethodType? paymentMethodType,
  }) {
    return PaymentHistoryState(
      userToken: userToken ?? this.userToken,
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
        userToken,
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
