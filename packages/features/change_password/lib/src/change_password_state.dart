part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({

    this.password = const Password.unvalidated(),
    this.newPassword = const Password.unvalidated(),
    this.newPasswordConfirmation = const PasswordConfirmation.unvalidated(),

    this.submissionStatus = FormzSubmissionStatus.initial,
  });


  final Password password;
  final Password newPassword;
  final PasswordConfirmation newPasswordConfirmation;

  final FormzSubmissionStatus submissionStatus;

  ChangePasswordState copyWith({

    Password? password,
    Password? newPassword,
    PasswordConfirmation? newPasswordConfirmation,

    FormzSubmissionStatus? submissionStatus,
  }) {
    return ChangePasswordState(

      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      newPasswordConfirmation: newPasswordConfirmation ?? this.newPasswordConfirmation,

      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [

        password,
        newPassword,
        newPasswordConfirmation,
        submissionStatus,
      ];
}

enum FetchStatus { initial, loading, success, failure }