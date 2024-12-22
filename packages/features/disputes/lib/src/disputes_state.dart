part of 'disputes_cubit.dart';

class DisputesState extends Equatable {
  const DisputesState({
    this.disputes,
    this.nextPage,
    this.nextListPageLoadError,
    this.disputesFetchStatus = FetchStatus.initial,
    this.userTypeFilter = UserType.requester,
    this.disputeStatusFilter = DisputeStatus.pendingReview,
  });

  final List<Dispute>? disputes;
  final int? nextPage;
  final dynamic nextListPageLoadError;
  final FetchStatus disputesFetchStatus;
  final UserType userTypeFilter;

  final DisputeStatus disputeStatusFilter;

  List<Dispute>? get ascendingSortedDisputes =>
      disputes?..sort((b, a) => a.createdAt.compareTo(b.createdAt));

  DisputesState copyWith({
    List<Dispute>? disputes,
    int? nextPage,
    dynamic nextListPageLoadError,
    FetchStatus? disputesFetchStatus,
    UserType? userTypeFilter,
    DisputeStatus? disputeStatusFilter,
  }) {
    return DisputesState(
      disputes: disputes ?? this.disputes,
      nextPage: nextPage,
      nextListPageLoadError: nextListPageLoadError,
      disputesFetchStatus: disputesFetchStatus ?? this.disputesFetchStatus,
      userTypeFilter: userTypeFilter ?? this.userTypeFilter,
      disputeStatusFilter: disputeStatusFilter ?? this.disputeStatusFilter,
    );
  }

  @override
  List<Object?> get props => [
        disputes,
        nextPage,
        nextListPageLoadError,
        disputesFetchStatus,
        userTypeFilter,
        disputeStatusFilter,
      ];
}

enum FetchStatus {
  initial,
  loading,
  success,
  failure,
}
