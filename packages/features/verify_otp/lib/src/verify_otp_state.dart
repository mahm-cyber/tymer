part of 'verify_otp_cubit.dart';

class VerifyOtpState extends Equatable {
  const VerifyOtpState({
    this.resendOtpTotalTime = 60 * 2,
    this.resendOtpSecondTimer = 00,
    this.resendOtpStatus = ResendOtpStatus.initial,
    this.otpVerification,
    this.otpCode = const OtpCode.unvalidated(),
    this.newPassword = const Password.unvalidated(),
    this.newPasswordConfirmation = const PasswordConfirmation.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.error,
  });

  final double resendOtpTotalTime;
  final double resendOtpSecondTimer;
  final ResendOtpStatus resendOtpStatus;
  final OtpVerification? otpVerification;
  final OtpCode otpCode;
  final Password newPassword;
  final PasswordConfirmation newPasswordConfirmation;
  final FormzSubmissionStatus submissionStatus;
  final dynamic error;
  VerifyOtpState copyWith({
    double? resendOtpTotalTime,
    double? resendOtpSecondTimer,
    ResendOtpStatus? resendOtpStatus,
    OtpVerification? otpVerification,
    OtpCode? otpCode,
    Password? newPassword,
    PasswordConfirmation? newPasswordConfirmation,
    FormzSubmissionStatus? submissionStatus,
    dynamic error,
  }) {
    return VerifyOtpState(
      resendOtpTotalTime: resendOtpTotalTime ?? this.resendOtpTotalTime,
      resendOtpSecondTimer: resendOtpSecondTimer ?? this.resendOtpSecondTimer,
      resendOtpStatus: resendOtpStatus ?? this.resendOtpStatus,
      otpVerification: otpVerification ?? this.otpVerification,
      otpCode: otpCode ?? this.otpCode,
      newPassword: newPassword ?? this.newPassword,
      newPasswordConfirmation:
          newPasswordConfirmation ?? this.newPasswordConfirmation,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        resendOtpTotalTime,
        resendOtpSecondTimer,
        resendOtpStatus,
        otpVerification,
        otpCode,
        newPassword,
        newPasswordConfirmation,
        submissionStatus,
        error,
      ];
}

enum ResendOtpStatus {
  initial,
  inProgress,
  success,
  error,
}
