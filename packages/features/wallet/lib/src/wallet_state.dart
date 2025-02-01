part of 'wallet_cubit.dart';

class WalletState extends Equatable {
  const WalletState({
    this.transactions,
    this.nextPage,
    this.nextListPageLoadError,
    this.transactionsFetchStatus = FetchStatus.initial,
  });

  final List<InAppTransaction>? transactions;
  final int? nextPage;
  final dynamic nextListPageLoadError;
  final FetchStatus transactionsFetchStatus;

  List<InAppTransaction>? get ascendingSortedTransactions =>
      transactions?..sort((b, a) => a.createdAt.compareTo(b.createdAt));

  WalletState copyWith({
    List<InAppTransaction>? transactions,
    int? nextPage,
    dynamic nextListPageLoadError,
    FetchStatus? transactionsFetchStatus,
  }) {
    return WalletState(
      transactions: transactions ?? this.transactions,
      nextPage: nextPage,
      nextListPageLoadError: nextListPageLoadError,
      transactionsFetchStatus:
          transactionsFetchStatus ?? this.transactionsFetchStatus,
    );
  }

  @override
  List<Object?> get props => [
        transactions,
        nextPage,
        nextListPageLoadError,
        transactionsFetchStatus,
      ];
}

enum FetchStatus {
  initial,
  loading,
  success,
  failure,
}
