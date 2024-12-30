import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit({
    required this.userRepository,
    required this.serviceRepository,
    required this.onViewDisputesTapped,
    required this.onCheckServiceRequestStatusTapped,
    required this.navigateToFulfillServiceRequest,
  })  : serviceRequestsPagingController = PagingController(firstPageKey: 1),
        super(
          const OrderHistoryState(),
        ) {
    serviceRepository.changeNotifier
        .addListener(_shouldReFetchServiceRequestsCallBack);
    _handleServiceRequestListNextPageRequested();
    serviceRequestsPagingController.addPageRequestListener(
      (pageNumber) {
        final isSubsequentPage = pageNumber > 1;
        if (isSubsequentPage) {
          _handleServiceRequestListNextPageRequested(page: pageNumber);
        }
      },
    );
  }

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback onViewDisputesTapped;
  final ValueSetter<int> onCheckServiceRequestStatusTapped;
  final PagingController<int, Service> serviceRequestsPagingController;
  final VoidCallback navigateToFulfillServiceRequest;

  void _shouldReFetchServiceRequestsCallBack() {
    final shouldReFetchDisputes =
        serviceRepository.changeNotifier.shouldReFetchServiceRequestsHistory;
    if (shouldReFetchDisputes == true) {
      _handleServiceRequestListNextPageRequested();
    }
  }

  Future _handleServiceRequestListNextPageRequested({
    int page = 1,
  }) async {
    try {
      final newPage = await serviceRepository.getAllServiceRequests(
        lat: 0.0,
        long: 0.0,
        userType: state.userTypeFilter,
        page: page,
        status: state.statusFilter,
      );

      final newItemList = newPage.list;
      final oldItemList = state.serviceRequests ?? [];
      final completeItemList =
          page == 1 ? newItemList : (oldItemList + newItemList);

      final nextPage = newPage.isLastPage! ? null : page + 1;

      final couponListPageState = state.copyWith(
        serviceRequests: completeItemList,
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
    final loadingFirstPageState = OrderHistoryState(
      nextPage: 1,
      statusFilter: state.statusFilter,
      userTypeFilter: state.userTypeFilter,
    );
    emit(loadingFirstPageState);
    _handleServiceRequestListNextPageRequested();
  }

  Future<void> reFetchNextSearchListPage() async {
    final nextPageKey = state.nextPage;
    final hasNextPage = nextPageKey != null;
    if (hasNextPage) {
      final nextPageState = state.copyWith(
        nextPage: nextPageKey,
      );
      emit(nextPageState);
      _handleServiceRequestListNextPageRequested(page: nextPageKey);
    }
  }

  void filterByServiceRequestStatus(ServiceStatus statusFilter) async {
    final newState = state.copyWith(
      statusFilter: statusFilter,
    );
    emit(newState);
    reFetchFirstPage();
  }

  void filterByUserType(UserType userType) async {
    final newState = state.copyWith(
      userTypeFilter: userType,
      statusFilter: userType == UserType.provider &&
              (state.statusFilter == ServiceStatus.pending ||
                  state.statusFilter == ServiceStatus.canceled)
          ? ServiceStatus.pendingReview
          : null,
    );
    emit(newState);
    reFetchFirstPage();
  }

  void onViewServiceRequestDetailsTapped(Service service) {
    final shouldCheckRequestedServiceStatus =
        state.userTypeFilter == UserType.requester;

    if (shouldCheckRequestedServiceStatus) {
      onCheckServiceRequestStatusTapped(service.id!);
    }

    final shouldCheckProvidedServiceStatus =
        service.status == ServiceStatus.inProgress ||
            service.status == ServiceStatus.pendingReview ||
            service.status == ServiceStatus.completed;

    if (shouldCheckProvidedServiceStatus &&
        state.userTypeFilter == UserType.provider) {
      serviceRepository.changeNotifier.setServiceRequest(service);

      navigateToFulfillServiceRequest();
    }
    // serviceRepository.changeNotifier.setServiceRequest(service);
  }

  @override
  Future<void> close() async {
    serviceRepository.changeNotifier
        .removeListener(_shouldReFetchServiceRequestsCallBack);
    return super.close();
  }
}
