part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.passwordInfoOverlayShown = false,
    this.passwordInfoOverlayYOffset = 0.0,
    this.newPassword = const Password.unvalidated(),
    this.newPasswordConfirmation = const PasswordConfirmation.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final bool passwordInfoOverlayShown;
  final double passwordInfoOverlayYOffset;
  final Password newPassword;
  final PasswordConfirmation newPasswordConfirmation;
  final FormzSubmissionStatus submissionStatus;

  ResetPasswordState copyWith({
    bool? passwordInfoOverlayShown,
    double? passwordInfoOverlayYOffset,
    Password? newPassword,
    PasswordConfirmation? newPasswordConfirmation,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return ResetPasswordState(
      passwordInfoOverlayShown:
          passwordInfoOverlayShown ?? this.passwordInfoOverlayShown,
      passwordInfoOverlayYOffset:
          passwordInfoOverlayYOffset ?? this.passwordInfoOverlayYOffset,
      newPassword: newPassword ?? this.newPassword,
      newPasswordConfirmation:
          newPasswordConfirmation ?? this.newPasswordConfirmation,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        passwordInfoOverlayShown,
        passwordInfoOverlayYOffset,
        newPassword,
        newPasswordConfirmation,
        submissionStatus,
      ];
}
