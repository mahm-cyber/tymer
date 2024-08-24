part of 'verify_otp_cubit.dart';

class VerifyOtpState extends Equatable {
  const VerifyOtpState({
    this.otpVerification,
    this.otpCode = const OtpCode.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final OtpVerification? otpVerification;
  final OtpCode otpCode;
  final FormzSubmissionStatus submissionStatus;

  VerifyOtpState copyWith({
    OtpVerification? otpVerification,
    OtpCode? otpCode,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return VerifyOtpState(
      otpVerification: otpVerification ?? this.otpVerification,
      otpCode: otpCode ?? this.otpCode,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        otpVerification,
        otpCode,
        submissionStatus,
      ];
}

enum AppDependenciesFetchStatus {
  initial,
  inProgress,
  success,
  error,
}
