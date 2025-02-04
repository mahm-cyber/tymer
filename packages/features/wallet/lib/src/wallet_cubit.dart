import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';
part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit({
    required this.userRepository,
    required this.walletRepository,
    required this.onTopUpTapped,
    required this.onWithdrawTapped,
  })  : transactionsPagingController = PagingController(firstPageKey: 1),
        super(const WalletState()) {
    _handleTransactionListNextPageRequested();
    transactionsPagingController.addPageRequestListener(
      (pageNumber) {
        final isSubsequentPage = pageNumber > 1;
        if (isSubsequentPage) {
          _handleTransactionListNextPageRequested(page: pageNumber);
        }
      },
    );
    userRepository.getFreshUser().then((user) {
      final newState = state.copyWith(
        balance: user.balance,
        nextPage: state.nextPage,
      );
      emit(newState);
    });
  }

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final VoidCallback onTopUpTapped;
  final VoidCallback onWithdrawTapped;
  final PagingController<int, Transaction> transactionsPagingController;

  Future _handleTransactionListNextPageRequested({
    int page = 1,
  }) async {
    try {
      final newPage = await walletRepository.getAllTransactions(
        page: page,
      );
      final newItemList = newPage.list;
      final oldItemList = state.transactions ?? [];
      final completeItemList =
          page == 1 ? newItemList : (oldItemList + newItemList);

      final nextPage = newPage.isLastPage ? null : page + 1;

      final transactionsListPageState = state.copyWith(
        transactions: completeItemList,
        nextPage: nextPage,
      );

      emit(transactionsListPageState);
    } catch (error) {
      final errorState = state.copyWith(
        nextListPageLoadError: error,
      );
      emit(errorState);
      rethrow;
    }
  }

  Future reFetchFirstPage() async {
    const loadingFirstPageState = WalletState(
      nextPage: 1,
      transactionsFetchStatus: FetchStatus.initial,
    );
    emit(loadingFirstPageState);
    final user = await userRepository.getFreshUser();
    final newState = state.copyWith(
      balance: user.balance,
      nextPage: state.nextPage,
    );
    emit(newState);
    _handleTransactionListNextPageRequested();
  }

  Future<void> reFetchNextSearchListPage() async {
    final nextPageKey = state.nextPage;
    final hasNextPage = nextPageKey != null;
    if (hasNextPage) {
      final nextPageState = state.copyWith(
        nextPage: nextPageKey,
      );
      emit(nextPageState);
      _handleTransactionListNextPageRequested(page: nextPageKey);
    }
  }

  Future<void> onNavigateToWithdrawTapped() async {
    walletRepository.changeNotifier.setPaymentType(TransactionType.withdraw);
    onWithdrawTapped();
  }

  Future<void> onNavigateToTopUpTapped() async {
    walletRepository.changeNotifier.setPaymentType(TransactionType.topup);
    onTopUpTapped();
  }

  @override
  Future<void> close() async {
    transactionsPagingController.dispose();
    return super.close();
  }
}
