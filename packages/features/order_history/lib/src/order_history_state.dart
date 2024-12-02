part of 'order_history_cubit.dart';

class OrderHistoryState extends Equatable {
  const OrderHistoryState({
    this.serviceRequests,
    this.serviceRequestsFetchStatus = FetchStatus.initial,
    this.locationServiceEnabled = false,
    this.locationPermission = PermissionStatus.denied,
  });

  final List<Service>? serviceRequests;
  final FetchStatus serviceRequestsFetchStatus;
  final bool locationServiceEnabled;
  final PermissionStatus locationPermission;

  List<Service>? get ascendingSortedServiceRequests =>
      serviceRequests?..sort((b, a) => a.createdAt!.compareTo(b.createdAt!));

  OrderHistoryState copyWith({
    List<Service>? serviceRequests,
    FetchStatus? serviceRequestsFetchStatus,
    bool? locationServiceEnabled,
    PermissionStatus? locationPermission,
  }) {
    return OrderHistoryState(
      serviceRequests: serviceRequests ?? this.serviceRequests,
      serviceRequestsFetchStatus:
          serviceRequestsFetchStatus ?? this.serviceRequestsFetchStatus,
      locationServiceEnabled:
          locationServiceEnabled ?? this.locationServiceEnabled,
      locationPermission: locationPermission ?? this.locationPermission,
    );
  }

  @override
  List<Object?> get props => [
        serviceRequests,
        serviceRequestsFetchStatus,
        locationServiceEnabled,
        locationPermission,
      ];
}

enum FetchStatus {
  initial,
  loading,
  success,
  failure,
}
