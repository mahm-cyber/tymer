part of 'verify_otp_cubit.dart';

class VerifyOtpState extends Equatable {
  const VerifyOtpState({
    this.resendOtpTotalTime = 60 * 2,
    this.resendOtpSecondTimer = 00,
    this.resendOtpStatus = ResendOtpStatus.initial,
    this.otpVerification,
    this.otpCode = const OtpCode.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final double resendOtpTotalTime;
  final double resendOtpSecondTimer;
  final ResendOtpStatus resendOtpStatus;
  final OtpVerification? otpVerification;
  final OtpCode otpCode;
  final FormzSubmissionStatus submissionStatus;

  VerifyOtpState copyWith({
    double? resendOtpTotalTime,
    double? resendOtpSecondTimer,
    ResendOtpStatus? resendOtpStatus,
    OtpVerification? otpVerification,
    OtpCode? otpCode,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return VerifyOtpState(
      resendOtpTotalTime: resendOtpTotalTime ?? this.resendOtpTotalTime,
      resendOtpSecondTimer: resendOtpSecondTimer ?? this.resendOtpSecondTimer,
      resendOtpStatus: resendOtpStatus ?? this.resendOtpStatus,
      otpVerification: otpVerification ?? this.otpVerification,
      otpCode: otpCode ?? this.otpCode,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        resendOtpTotalTime,
        resendOtpSecondTimer,
        resendOtpStatus,
        otpVerification,
        otpCode,
        submissionStatus,
      ];
}

enum ResendOtpStatus {
  initial,
  inProgress,
  success,
  error,
}
