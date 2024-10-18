part of 'provide_service_cubit.dart';

class ProvideServiceState extends Equatable {
  const ProvideServiceState({
    this.serviceRequests,
    this.serviceRequestsFetchStatus = FetchStatus.initial,
    this.locationServiceEnabled = false,
    this.locationPermission = PermissionStatus.denied,
  });

  final List<Service>? serviceRequests;
  final FetchStatus serviceRequestsFetchStatus;
  final bool locationServiceEnabled;
  final PermissionStatus locationPermission;

  List<Service>? get ascendingSortedServiceRequests => serviceRequests
      ?.where((service) => service.status == ServiceStatus.pending)
      .toList()
        ?..sort((b, a) => a.createdAt!.compareTo(b.createdAt!));

  ProvideServiceState copyWith({
    List<Service>? serviceRequests,
    FetchStatus? serviceRequestsFetchStatus,
    bool? locationServiceEnabled,
    PermissionStatus? locationPermission,
  }) {
    return ProvideServiceState(
      serviceRequests: serviceRequests ?? this.serviceRequests,
      serviceRequestsFetchStatus:
          serviceRequestsFetchStatus ?? this.serviceRequestsFetchStatus,
      locationServiceEnabled: locationServiceEnabled ?? this.locationServiceEnabled,
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
