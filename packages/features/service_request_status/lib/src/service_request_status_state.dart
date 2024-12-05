part of 'service_request_status_cubit.dart';

class ServiceRequestStatusState extends Equatable {
  const ServiceRequestStatusState({
    this.fetchStatus = FetchStatus.initial,
    this.service,
    this.confirmationStatus = ConfirmationStatus.initial,
    this.cancellationStatus = CancellationStatus.initial,
    this.userToken,
  });

  final FetchStatus fetchStatus;
  final Service? service;
  final ConfirmationStatus confirmationStatus;
  final CancellationStatus cancellationStatus;
  final String? userToken;

  ServiceRequestStatusState copyWith({
    FetchStatus? fetchStatus,
    Service? service,
    ConfirmationStatus? confirmationStatus,
    CancellationStatus? cancellationStatus,
    String? userToken,
  }) {
    return ServiceRequestStatusState(
      fetchStatus: fetchStatus ?? this.fetchStatus,
      service: service ?? this.service,
      confirmationStatus: confirmationStatus ?? this.confirmationStatus,
      cancellationStatus: cancellationStatus ?? this.cancellationStatus,
      userToken: userToken ?? this.userToken,
    );
  }

  @override
  List<Object?> get props => [
        fetchStatus,
        service,
        confirmationStatus,
        cancellationStatus,
        userToken,
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

