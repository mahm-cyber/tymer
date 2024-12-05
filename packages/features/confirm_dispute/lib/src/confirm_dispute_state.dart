part of 'confirm_dispute_cubit.dart';

class ConfirmDisputeState extends Equatable {
  const ConfirmDisputeState({
    this.reason,
    this.disputingStatus = DisputingStatus.initial,
  });

  final String? reason;
  final DisputingStatus disputingStatus;

  ConfirmDisputeState copyWith({
    String? reason,
    DisputingStatus? disputingStatus,
  }) {
    return ConfirmDisputeState(
      reason: reason ?? this.reason,
      disputingStatus: disputingStatus ?? DisputingStatus.initial,
    );
  }

  @override
  List<Object?> get props => [
        reason,
        disputingStatus,
      ];
}

enum DisputingStatus {
  initial,
  loading,
  success,
  error,
}
