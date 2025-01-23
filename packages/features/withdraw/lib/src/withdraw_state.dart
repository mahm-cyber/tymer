part of 'withdraw_cubit.dart';

class WithdrawState extends Equatable {
  const WithdrawState({
    this.withdrawAmount = const Dynamic<String?>.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final Dynamic<String?> withdrawAmount;
  final FormzSubmissionStatus submissionStatus;

  WithdrawState copyWith({
    Dynamic<String?>? withdrawAmount,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return WithdrawState(
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        withdrawAmount,
        submissionStatus,
      ];
}
