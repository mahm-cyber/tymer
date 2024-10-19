part of 'accept_service_request_cubit.dart';

class AcceptServiceRequestState extends Equatable {

  const AcceptServiceRequestState({
    this.service,
    this.isViewingLocation = false,
    this.myLocation,
    this.submissionStatus = SubmissionStatus.initial,
  });

  final Service? service;
  final bool isViewingLocation;
  final LocationData? myLocation;
  final SubmissionStatus submissionStatus;

  AcceptServiceRequestState copyWith({
    Service? service,
    bool? isViewingLocation,
    LocationData? myLocation,
    SubmissionStatus? submissionStatus,
  }) {
    return AcceptServiceRequestState(
      service: service ?? this.service,
      isViewingLocation: isViewingLocation ?? this.isViewingLocation,
      myLocation: myLocation ?? this.myLocation,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        service,
        isViewingLocation,
        myLocation,
        submissionStatus,
      ];
}

enum SubmissionStatus {
  initial,
  submitting,
  success,
  failure,
}