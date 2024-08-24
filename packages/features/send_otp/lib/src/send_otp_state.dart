part of 'send_otp_cubit.dart';

class SendOtpState extends Equatable {
  const SendOtpState({
    this.email = const Email.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final Email email;
  final FormzSubmissionStatus submissionStatus;

  SendOtpState copyWith({
    Email? email,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SendOtpState(
      email: email ?? this.email,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        email,
        submissionStatus,
      ];
}
