part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.phone = const Mobile.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final Mobile phone;
  final FormzSubmissionStatus submissionStatus;

  ForgotPasswordState copyWith({
    Mobile? phone,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return ForgotPasswordState(
      phone: phone ?? this.phone,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        phone,
        submissionStatus,
      ];
}
