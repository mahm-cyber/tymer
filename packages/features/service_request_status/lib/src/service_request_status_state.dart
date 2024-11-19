part of 'service_request_status_cubit.dart';

class ServiceRequestStatusState extends Equatable {
  const ServiceRequestStatusState({
    this.fetchStatus = FetchStatus.initial,
    this.service,
    this.confirmationStatus = ConfirmationStatus.initial,
    this.cancellationStatus = CancellationStatus.initial,
  });

  final FetchStatus fetchStatus;
  final Service? service;
  final ConfirmationStatus confirmationStatus;
  final CancellationStatus cancellationStatus;

  ServiceRequestStatusState copyWith({
    FetchStatus? fetchStatus,
    Service? service,
    ConfirmationStatus? confirmationStatus,
    CancellationStatus? cancellationStatus,
  }) {
    return ServiceRequestStatusState(
      fetchStatus: fetchStatus ?? this.fetchStatus,
      service: service ?? this.service,
      confirmationStatus: confirmationStatus ?? this.confirmationStatus,
      cancellationStatus: cancellationStatus ?? this.cancellationStatus,
    );
  }

  @override
  List<Object?> get props => [
        fetchStatus,
        service,
        confirmationStatus,
        cancellationStatus,
      ];
}

enum FetchStatus {
  initial,
  loading,
  loaded,
  error,
}

enum ConfirmationStatus {
  initial,
  loading,
  success,
  error,
}

enum CancellationStatus {
  initial,
  loading,
  success,
  error,
}
