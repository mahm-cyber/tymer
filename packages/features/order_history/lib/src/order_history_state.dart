part of 'order_history_cubit.dart';

class OrderHistoryState extends Equatable {
  const OrderHistoryState({
    this.serviceRequests,
    this.nextPage,
    this.nextListPageLoadError,
    this.serviceRequestsFetchStatus = FetchStatus.initial,
    this.userTypeFilter = UserType.requester,
    this.statusFilter = ServiceStatus.completed,
  });

  final List<Service>? serviceRequests;
  final int? nextPage;
  final dynamic nextListPageLoadError;
  final FetchStatus serviceRequestsFetchStatus;
  final UserType userTypeFilter;
  final ServiceStatus statusFilter;

  List<ServiceStatus> get serviceStatusFilters =>
      userTypeFilter == UserType.requester
          ? [
              ServiceStatus.pending,
              ServiceStatus.inProgress,
              ServiceStatus.completed,
              ServiceStatus.canceled,
              ServiceStatus.pendingReview,
            ]
          : [
              ServiceStatus.inProgress,
              ServiceStatus.completed,
              ServiceStatus.canceled,
              ServiceStatus.pendingReview,
            ];

  OrderHistoryState copyWith({
    List<Service>? serviceRequests,
    int? nextPage,
    dynamic nextListPageLoadError,
    FetchStatus? serviceRequestsFetchStatus,
    UserType? userTypeFilter,
    ServiceStatus? statusFilter,
  }) {
    return OrderHistoryState(
      serviceRequests: serviceRequests ?? this.serviceRequests,
      nextPage: nextPage,
      nextListPageLoadError: nextListPageLoadError,
      serviceRequestsFetchStatus:
          serviceRequestsFetchStatus ?? this.serviceRequestsFetchStatus,
      userTypeFilter:
          userTypeFilter ?? this.userTypeFilter,
      statusFilter: statusFilter ?? this.statusFilter,
    );
  }

  @override
  List<Object?> get props => [
        serviceRequests,
        nextPage,
        nextListPageLoadError,
        serviceRequestsFetchStatus,
        userTypeFilter,
        statusFilter,
      ];
}

enum FetchStatus {
  initial,
  loading,
  success,
  failure,
}
