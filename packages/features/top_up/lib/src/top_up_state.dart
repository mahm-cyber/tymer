part of 'top_up_cubit.dart';

class TopUpState extends Equatable {
  const TopUpState({
    this.topUpAmount = const Dynamic<String?>.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final Dynamic<String?> topUpAmount;
  final FormzSubmissionStatus submissionStatus;

  TopUpState copyWith({
    Dynamic<String?>? topUpAmount,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return TopUpState(
      topUpAmount: topUpAmount ?? this.topUpAmount,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        topUpAmount,
        submissionStatus,
      ];
}
