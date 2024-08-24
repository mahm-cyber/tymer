part of 'initial_cubit.dart';

class InitialState extends Equatable {
  const InitialState({
    this.shouldRememberCredentials = true,
    this.rememberMeLoading = false,
    this.rememberMe = const RememberMe(),
    this.appDependenciesFetchStatus = AppDependenciesFetchStatus.initial,
    this.email = const Email.unvalidated(),
    this.password = const Password.unvalidated(),
    this.submissionStatus = SubmissionStatus.idle,
  });

  final bool shouldRememberCredentials;
  final bool rememberMeLoading;
  final RememberMe rememberMe;
  final AppDependenciesFetchStatus appDependenciesFetchStatus;
  final Email email;
  final Password password;
  final SubmissionStatus submissionStatus;

  InitialState copyWith({
    bool? shouldRememberCredentials,
    bool? rememberMeLoading,
    RememberMe? rememberMe,
    AppDependenciesFetchStatus? appDependenciesFetchStatus,
    Email? email,
    Password? password,
    SubmissionStatus? submissionStatus,
  }) {
    return InitialState(
      shouldRememberCredentials:
          shouldRememberCredentials ?? this.shouldRememberCredentials,
      rememberMeLoading: rememberMeLoading ?? this.rememberMeLoading,
      rememberMe: rememberMe ?? this.rememberMe,
      appDependenciesFetchStatus:
          appDependenciesFetchStatus ?? this.appDependenciesFetchStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        shouldRememberCredentials,
        rememberMeLoading,
        rememberMe,
        appDependenciesFetchStatus,
        email,
        password,
        submissionStatus,
      ];
}

enum AppDependenciesFetchStatus {
  initial,
  inProgress,
  success,
  error,
}

enum SubmissionStatus {
  idle,
  inProgress,
  success,
  genericError,
  invalidCredentialsError,
}
