part of 'provide_service_cubit.dart';

class ProvideServiceState extends Equatable {
  const ProvideServiceState({
    this.serviceRequests,
    this.serviceRequestsFetchStatus = FetchStatus.initial,
    this.runningServiceRequest,
    this.locationData,
    this.locationDataStatus = LocationDataStatus.initial,
    this.isMapViewActive = false,
  });

  final List<Service>? serviceRequests;
  final FetchStatus serviceRequestsFetchStatus;
  final Service? runningServiceRequest;
  final LocationData? locationData;
  final LocationDataStatus locationDataStatus;
  final bool isMapViewActive;

  List<Service>? get ascendingSortedServiceRequests => serviceRequests
      ?.where((service) => service.status == ServiceStatus.pending)
      .toList()
        ?..sort((b, a) => a.createdAt!.compareTo(b.createdAt!));

  ProvideServiceState copyWith({
    List<Service>? serviceRequests,
    FetchStatus? serviceRequestsFetchStatus,
    Service? runningServiceRequest,
    LocationData? locationData,
    LocationDataStatus? locationDataStatus,
    bool? isMapViewActive,
  }) {
    return ProvideServiceState(
      serviceRequests: serviceRequests ?? this.serviceRequests,
      serviceRequestsFetchStatus:
          serviceRequestsFetchStatus ?? this.serviceRequestsFetchStatus,
      runningServiceRequest: runningServiceRequest ?? this.runningServiceRequest,
      locationData: locationData ?? this.locationData,
      locationDataStatus: locationDataStatus ?? this.locationDataStatus,
      isMapViewActive: isMapViewActive ?? this.isMapViewActive,
    );
  }

  @override
  List<Object?> get props => [
        serviceRequests,
        serviceRequestsFetchStatus,
        runningServiceRequest,
        locationData,
        locationDataStatus,
        isMapViewActive,
      ];
}

enum FetchStatus {
  initial,
  loading,
  success,
  failure,
}

enum LocationDataStatus {
  initial,
  loading,
  success,
  failure,
}