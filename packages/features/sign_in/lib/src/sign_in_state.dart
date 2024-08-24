part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.shouldRememberCredentials = true,
    this.rememberMeLoading = false,
    this.rememberMe = const RememberMe(),
    this.email = const Email.unvalidated(),
    this.password = const Password.unvalidated(),
    this.error,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final bool shouldRememberCredentials;
  final bool rememberMeLoading;
  final RememberMe rememberMe;
  final Email email;
  final Password password;
  final dynamic error;
  final FormzSubmissionStatus submissionStatus;

  SignInState copyWith({
    bool? shouldRememberCredentials,
    bool? rememberMeLoading,
    RememberMe? rememberMe,
    Email? email,
    Password? password,
    dynamic error,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SignInState(
      shouldRememberCredentials:
          shouldRememberCredentials ?? this.shouldRememberCredentials,
      rememberMeLoading: rememberMeLoading ?? this.rememberMeLoading,
      rememberMe: rememberMe ?? this.rememberMe,
      email: email ?? this.email,
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
        email,
        password,
        error,
        submissionStatus,
      ];
}
