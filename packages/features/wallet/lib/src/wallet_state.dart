part of 'wallet_cubit.dart';

class WalletState extends Equatable {
  const WalletState({
    this.transactions,
    this.nextPage,
    this.nextListPageLoadError,
    this.transactionsFetchStatus = FetchStatus.initial,
    this.balance,
  });

  final List<Transaction>? transactions;
  final int? nextPage;
  final dynamic nextListPageLoadError;
  final FetchStatus transactionsFetchStatus;
  final double? balance;
  // List<InAppTransaction>? get ascendingSortedTransactions =>
  //     transactions?..sort((b, a) => a.createdAt.compareTo(b.createdAt));

  WalletState copyWith({
    List<Transaction>? transactions,
    int? nextPage,
    dynamic nextListPageLoadError,
    FetchStatus? transactionsFetchStatus,
    double? balance,
  }) {
    return WalletState(
      transactions: transactions ?? this.transactions,
      nextPage: nextPage,
      nextListPageLoadError: nextListPageLoadError,
      transactionsFetchStatus:
          transactionsFetchStatus ?? this.transactionsFetchStatus,
      balance: balance ?? this.balance,
    );
  }

  @override
  List<Object?> get props => [
        transactions,
        nextPage,
        nextListPageLoadError,
        transactionsFetchStatus,
        balance,
      ];
}

enum FetchStatus {
  initial,
  loading,
  success,
  failure,
}
