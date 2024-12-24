part of 'change_phone_cubit.dart';

class ChangePhoneState extends Equatable {
  const ChangePhoneState({
    this.shouldRememberCredentials = false,
    this.rememberMeLoading = false,
    this.rememberMe = const RememberMe(),
    this.phone = const Mobile.unvalidated(),
    this.password = const Password.unvalidated(),
    this.error,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final bool shouldRememberCredentials;
  final bool rememberMeLoading;
  final RememberMe rememberMe;
  final Mobile phone;
  final Password password;
  final dynamic error;
  final FormzSubmissionStatus submissionStatus;

  ChangePhoneState copyWith({
    bool? shouldRememberCredentials,
    bool? rememberMeLoading,
    RememberMe? rememberMe,
    Mobile? phone,
    Password? password,
    dynamic error,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return ChangePhoneState(
      shouldRememberCredentials:
          shouldRememberCredentials ?? this.shouldRememberCredentials,
      rememberMeLoading: rememberMeLoading ?? this.rememberMeLoading,
      rememberMe: rememberMe ?? this.rememberMe,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      error: error,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        shouldRememberCredentials,
        rememberMeLoading,
        rememberMe,
        phone,
        password,
        error,
        submissionStatus,
      ];
}
