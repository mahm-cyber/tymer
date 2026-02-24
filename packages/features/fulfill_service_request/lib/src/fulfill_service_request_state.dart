part of 'fulfill_service_request_cubit.dart';

class FulfillServiceRequestState extends Equatable {
  const FulfillServiceRequestState({
    this.fetchStatus = FetchStatus.initial,
    this.userToken,
    this.service,
    this.reservationNumber = const Dynamic<String>.unvalidated(),
    this.day = const Dynamic<DateTime?>.unvalidated(),
    this.time = const Dynamic<TimeOfDay?>.unvalidated(),
    this.file = const FileSize<File?>.unvalidated(),
    this.imageFileName,
    this.isImagePickerBottomSheetVisible = false,
    this.additionalDetails,
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.cancelStatus = FormzSubmissionStatus.initial,
  });

  final FetchStatus fetchStatus;
  final String? userToken;
  final Service? service;
  final Dynamic<String> reservationNumber;
  final Dynamic<DateTime?> day;
  final Dynamic<TimeOfDay?> time;
  final FileSize<File?> file;
  final String? imageFileName;
  final bool isImagePickerBottomSheetVisible;
  final String? additionalDetails;
  final FormzSubmissionStatus submissionStatus;
  final FormzSubmissionStatus cancelStatus;

  FulfillServiceRequestState copyWith({
    FetchStatus? fetchStatus,
    String? userToken,
    Service? service,
    Dynamic<String>? reservationNumber,
    Dynamic<DateTime?>? day,
    Dynamic<TimeOfDay?>? time,
    FileSize<File?>? file,
    String? imageFileName,
    bool? isImagePickerBottomSheetVisible,
    String? additionalDetails,
    FormzSubmissionStatus? submissionStatus,
    FormzSubmissionStatus? cancelStatus,
  }) {
    return FulfillServiceRequestState(
      fetchStatus: fetchStatus ?? this.fetchStatus,
      userToken: userToken ?? this.userToken,
      service: service ?? this.service,
      reservationNumber: reservationNumber ?? this.reservationNumber,
      day: day ?? this.day,
      time: time ?? this.time,
      file: file ?? this.file,
      imageFileName: imageFileName ?? this.imageFileName,
      isImagePickerBottomSheetVisible: isImagePickerBottomSheetVisible ??
          this.isImagePickerBottomSheetVisible,
      additionalDetails: additionalDetails ?? this.additionalDetails,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      cancelStatus: cancelStatus ?? this.cancelStatus,
    );
  }

  @override
  List<Object?> get props => [
        fetchStatus,
        userToken,
        service,
        reservationNumber,
        day,
        time,
        file,
        imageFileName,
        isImagePickerBottomSheetVisible,
        additionalDetails,
        submissionStatus,
        cancelStatus,
      ];
}

enum FetchStatus {
  initial,
  loading,
  success,
  failure,
}
