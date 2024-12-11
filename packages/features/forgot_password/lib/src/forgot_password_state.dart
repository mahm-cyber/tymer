part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.phone = const Mobile.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.error ,
  });

  final Mobile phone;
  final FormzSubmissionStatus submissionStatus;
  final dynamic error;

  ForgotPasswordState copyWith({
    Mobile? phone,
    FormzSubmissionStatus? submissionStatus,
    dynamic error,
  }) {
    return ForgotPasswordState(
      phone: phone ?? this.phone,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        phone,
        submissionStatus,
        error,
      ];
}
