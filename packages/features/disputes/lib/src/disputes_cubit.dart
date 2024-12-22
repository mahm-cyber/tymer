import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

part 'disputes_state.dart';

class DisputesCubit extends Cubit<DisputesState> {
  DisputesCubit({
    required this.userRepository,
    required this.serviceRepository,
    required this.onDisputeTapped,
  })  : serviceRequestsPagingController = PagingController(firstPageKey: 1),
        super(
          const DisputesState(),
        ) {
    serviceRepository.changeNotifier.shouldReFetchDisputesVN
        .addListener(_shouldReFetchDisputesCallBack);
    _handleDisputesListNextPageRequested();
    serviceRequestsPagingController.addPageRequestListener(
      (pageNumber) {
        final isSubsequentPage = pageNumber > 1;
        if (isSubsequentPage) {
          _handleDisputesListNextPageRequested(page: pageNumber);
        }
      },
    );
  }

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final ValueSetter<int> onDisputeTapped;
  final PagingController<int, Dispute> serviceRequestsPagingController;

  Future _handleDisputesListNextPageRequested({
    int page = 1,
  }) async {
    try {
      final newPage = await serviceRepository.getDisputes(
        page: page,
        userType: state.userTypeFilter,
        disputeStatus: state.disputeStatusFilter,
      );

      final newItemList = newPage.list.reversed.toList();
      final oldItemList = state.disputes ?? [];
      final completeItemList =
          page == 1 ? newItemList : (oldItemList + newItemList);

      final nextPage = newPage.isLastPage ? null : page + 1;

      final couponListPageState = state.copyWith(
        disputes: completeItemList,
        nextPage: nextPage,
      );

      emit(couponListPageState);
    } catch (error) {
      final errorState = state.copyWith(
        nextListPageLoadError: error,
      );
      emit(errorState);
      rethrow;
    }
  }

  Future reFetchFirstPage() async {
    final loadingFirstPageState = DisputesState(
      nextPage: 1,
      disputeStatusFilter: state.disputeStatusFilter,
      userTypeFilter: state.userTypeFilter,
    );
    emit(loadingFirstPageState);
    _handleDisputesListNextPageRequested();
  }

  Future<void> reFetchNextSearchListPage() async {
    final nextPageKey = state.nextPage;
    final hasNextPage = nextPageKey != null;
    if (hasNextPage) {
      final nextPageState = state.copyWith(
        nextPage: nextPageKey,
      );
      emit(nextPageState);
      _handleDisputesListNextPageRequested(page: nextPageKey);
    }
  }

  void setFilterByDisputeStatus(DisputeStatus disputeStatusFilter) async {
    final newState = state.copyWith(
      disputeStatusFilter: disputeStatusFilter,
    );
    emit(newState);
    reFetchFirstPage();
  }

  void filterByUserType(UserType userType) async {
    final newState = state.copyWith(
      userTypeFilter: userType,
    );
    emit(newState);
    reFetchFirstPage();
  }

  void onGoToDisputeChatTapped(Dispute dispute) async {
    serviceRepository.changeNotifier
        .setDisputeChatUserType(state.userTypeFilter);
    await serviceRepository.changeNotifier.setCurrentDispute(dispute);
    onDisputeTapped(dispute.id);
  }

  void _shouldReFetchDisputesCallBack() {
    final shouldReFetchDisputes =
        serviceRepository.changeNotifier.shouldReFetchDisputesVN.value;
    if (shouldReFetchDisputes == true) {
      _handleDisputesListNextPageRequested();
    }
  }

  @override
  Future<void> close() async {
    serviceRepository.changeNotifier.shouldReFetchDisputesVN
        .removeListener(_shouldReFetchDisputesCallBack);
    return super.close();
  }
}
