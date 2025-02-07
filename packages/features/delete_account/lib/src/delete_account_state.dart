part of 'delete_account_cubit.dart';

class DeleteAccountState extends Equatable {
  const DeleteAccountState({
    this.password = const Password.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final Password password;
  final FormzSubmissionStatus submissionStatus;
  DeleteAccountState copyWith({
    Password? password,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return DeleteAccountState(
      password: password ?? this.password,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        password,
        submissionStatus,
      ];
}

