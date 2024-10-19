part of 'fulfill_service_request_cubit.dart';

class FulfillServiceRequestState extends Equatable {
  const FulfillServiceRequestState({
    this.service,
    this.reservationNumber = const Dynamic<String>.unvalidated(),
    this.waitingTime = const Dynamic<String>.unvalidated(),
    this.imageBytes,
    this.isImagePickerBottomSheetVisible = false,
    this.additionalDetails,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final Service? service;
  final Dynamic<String> reservationNumber;
  final Dynamic<String> waitingTime;
  final Uint8List? imageBytes;
  final bool isImagePickerBottomSheetVisible;
  final String? additionalDetails;
  final FormzSubmissionStatus submissionStatus;

  FulfillServiceRequestState copyWith({
    Service? service,
    Dynamic<String>? reservationNumber,
    Dynamic<String>? waitingTime,
    Uint8List? imageBytes,
    bool? isImagePickerBottomSheetVisible,
    String? additionalDetails,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return FulfillServiceRequestState(
      service: service ?? this.service,
      reservationNumber: reservationNumber ?? this.reservationNumber,
      waitingTime: waitingTime ?? this.waitingTime,
      imageBytes: imageBytes ?? this.imageBytes,
      isImagePickerBottomSheetVisible: isImagePickerBottomSheetVisible ??
          this.isImagePickerBottomSheetVisible,
      additionalDetails: additionalDetails ?? this.additionalDetails,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        service,
        reservationNumber,
        waitingTime,
        imageBytes,
        isImagePickerBottomSheetVisible,
        additionalDetails,
        submissionStatus,
      ];
}
