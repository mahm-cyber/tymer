part of 'accept_service_request_cubit.dart';

class AcceptServiceRequestState extends Equatable {
  const AcceptServiceRequestState({
    this.service,
    this.isViewingLocation = false,
    this.myLocation,
    this.submissionStatus = SubmissionStatus.initial,
    this.error,
  });

  final Service? service;
  final bool isViewingLocation;
  final LocationData? myLocation;
  final SubmissionStatus submissionStatus;
  final dynamic error;

  AcceptServiceRequestState copyWith({
    Service? service,
    bool? isViewingLocation,
    LocationData? myLocation,
    SubmissionStatus? submissionStatus,
    dynamic error,
  }) {
    return AcceptServiceRequestState(
      service: service ?? this.service,
      isViewingLocation: isViewingLocation ?? this.isViewingLocation,
      myLocation: myLocation ?? this.myLocation,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        service,
        isViewingLocation,
        myLocation,
        submissionStatus,
        error,
      ];
}

enum SubmissionStatus {
  initial,
  submitting,
  success,
  failure,
}
