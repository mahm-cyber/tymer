part of 'service_request_status_cubit.dart';

class ServiceRequestStatusState extends Equatable {
  const ServiceRequestStatusState({
    this.fetchStatus = FetchStatus.initial,
    this.service,
  });

  final FetchStatus fetchStatus;
  final Service? service;

  ServiceRequestStatusState copyWith({
    FetchStatus? fetchStatus,
    Service? service,
  }) {
    return ServiceRequestStatusState(
      fetchStatus: fetchStatus ?? this.fetchStatus,
      service: service ?? this.service,
    );
  }
  @override
  List<Object?> get props => [
        fetchStatus,
        service,
  ];
}

enum FetchStatus {
  initial,
  loading,
  loaded,
  error,
}
