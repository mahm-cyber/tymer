import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'payment_history_state.dart';

class PaymentHistoryCubit extends Cubit<PaymentHistoryState> {
  PaymentHistoryCubit({
    required this.userRepository,
    required this.walletRepository,
  })  : paymentsPagingController = PagingController(firstPageKey: 1),
        super(PaymentHistoryState(
          paymentType: walletRepository.changeNotifier.paymentType,
        )) {
    userRepository.getUserToken().then((token) {
      emit(state.copyWith(userToken: token));
    });
    _handlePaymentListNextPageRequested();
    paymentsPagingController.addPageRequestListener(
      (pageNumber) {
        final isSubsequentPage = pageNumber > 1;
        if (isSubsequentPage) {
          _handlePaymentListNextPageRequested(page: pageNumber);
        }
      },
    );
  }

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final PagingController<int, Payment> paymentsPagingController;

  Future _handlePaymentListNextPageRequested({
    int page = 1,
  }) async {
    try {
      final newPage = await walletRepository.getPayments(
        type: state.paymentType!,
        paymentMethodType: state.paymentMethodType!,
        page: page,
      );

      final newItemList = newPage.list;
      final oldItemList = state.payments ?? [];
      final completeItemList =
          page == 1 ? newItemList : (oldItemList + newItemList);

      final nextPage = newPage.isLastPage! ? null : page + 1;

      final paymentsListPageState = state.copyWith(
        payments: completeItemList,
        nextPage: nextPage,
      );

      emit(paymentsListPageState);
    } catch (error) {
      final errorState = state.copyWith(
        nextListPageLoadError: error,
      );
      emit(errorState);
      rethrow;
    }
  }

  Future reFetchFirstPage() async {
    final loadingFirstPageState = PaymentHistoryState(
      nextPage: 1,
      statusFilter: state.statusFilter,
      paymentType: state.paymentType,
      paymentMethodType: state.paymentMethodType,
      paymentsFetchStatus: FetchStatus.initial,
      userToken: state.userToken,
    );
    emit(loadingFirstPageState);
    _handlePaymentListNextPageRequested();
  }

  Future<void> reFetchNextSearchListPage() async {
    final nextPageKey = state.nextPage;
    final hasNextPage = nextPageKey != null;
    if (hasNextPage) {
      final nextPageState = state.copyWith(
        nextPage: nextPageKey,
      );
      emit(nextPageState);
      _handlePaymentListNextPageRequested(page: nextPageKey);
    }
  }

  void filterByPaymentStatus(PaymentStatus statusFilter) async {
    final newState = state.copyWith(
      statusFilter: statusFilter,
    );
    emit(newState);
    reFetchFirstPage();
  }

  void filterByPaymentMethodType(PaymentMethodType? paymentMethodType) async {
    final newState = state.copyWith(
      paymentMethodType: paymentMethodType,
    );
    emit(newState);
    reFetchFirstPage();
  }

  // @override
  // Future<void> close() async {
  //   return super.close();
  // }
//onchange
  // @override
  // void onChange(Change<PaymentHistoryState> change) {
  //   super.onChange(change);
  //   //paymentmethodtype changes per state
  //   //previous and next state
  //   debugPrint(
  //       'CURRENT:::${change.currentState.paymentMethodType} NEXT:::${change.nextState.paymentMethodType}');
  // }
}
