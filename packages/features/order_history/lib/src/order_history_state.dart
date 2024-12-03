part of 'order_history_cubit.dart';

class OrderHistoryState extends Equatable {
  const OrderHistoryState({
    this.serviceRequests,
    this.nextPage,
    this.nextListPageLoadError,
    this.serviceRequestsFetchStatus = FetchStatus.initial,
    this.statusFilter = ServiceStatus.completed,
  });

  final List<Service>? serviceRequests;
  final int? nextPage;
  final dynamic nextListPageLoadError;
  final FetchStatus serviceRequestsFetchStatus;
  final ServiceStatus statusFilter;

  OrderHistoryState copyWith({
    List<Service>? serviceRequests,
    int? nextPage,
    dynamic nextListPageLoadError,
    FetchStatus? serviceRequestsFetchStatus,
    ServiceStatus? statusFilter,
  }) {
    return OrderHistoryState(
      serviceRequests: serviceRequests ?? this.serviceRequests,
      nextPage: nextPage ,
      nextListPageLoadError: nextListPageLoadError,
      serviceRequestsFetchStatus:
          serviceRequestsFetchStatus ?? this.serviceRequestsFetchStatus,
      statusFilter: statusFilter ?? this.statusFilter,
    );
  }

  @override
  List<Object?> get props => [
        serviceRequests,
        nextPage,
        nextListPageLoadError,
        serviceRequestsFetchStatus,
        statusFilter,
      ];
}

enum FetchStatus {
  initial,
  loading,
  success,
  failure,
}
