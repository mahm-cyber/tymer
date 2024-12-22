part of 'confirm_dispute_cubit.dart';

class ConfirmDisputeState extends Equatable {
  const ConfirmDisputeState({
    this.reason,
    this.disputeId,
    this.disputingStatus = DisputingStatus.initial,
  });

  final String? reason;
  final int? disputeId;
  final DisputingStatus disputingStatus;

  ConfirmDisputeState copyWith({
    String? reason,
    int? disputeId,
    DisputingStatus? disputingStatus,
  }) {
    return ConfirmDisputeState(
      reason: reason ?? this.reason,
      disputeId: disputeId ?? this.disputeId,
      disputingStatus: disputingStatus ?? DisputingStatus.initial,
    );
  }

  @override
  List<Object?> get props => [
        reason,
        disputeId,
        disputingStatus,
      ];
}

enum DisputingStatus {
  initial,
  loading,
  success,
  error,
}
