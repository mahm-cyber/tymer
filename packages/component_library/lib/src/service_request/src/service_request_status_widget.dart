import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class DisputeStatusWidget extends StatelessWidget {
  const DisputeStatusWidget({
    super.key,
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 140,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.smallMedium,
        vertical: Spacing.xSmall,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
          color: color,
        ),
      ),
      child: Text(
        label,
        style: textTheme.bodyMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}

String serviceRequestStatusToLocalizedString(
  ServiceStatus serviceRequestStatus,
  ComponentLibraryLocalizations l10n,
) {
  switch (serviceRequestStatus) {
    case ServiceStatus.pending:
      return l10n.pendingServiceRequestStatus;
    case ServiceStatus.inProgress:
      return l10n.inProgressServiceRequestStatus;
    case ServiceStatus.completed:
      return l10n.completedServiceRequestStatus;
    case ServiceStatus.canceled:
      return l10n.canceledServiceRequestStatus;
    case ServiceStatus.pendingReview:
      return l10n.pendingReviewServiceRequestStatus;
    case ServiceStatus.disputed:
      return l10n.disputedServiceRequestStatus;
  }
}

// ServiceRequestsFetchMode

String userTypeToLocalizedString(
  UserType userType,
  ComponentLibraryLocalizations l10n,
) {
  switch (userType) {
    case UserType.requester:
      return l10n.requesterServiceRequestsFetchMode;
    case UserType.provider:
      return l10n.providerServiceRequestsFetchMode;
  }
}

String disputeStatusToLocalizedString(
    DisputeStatus disputeStatus,
    ComponentLibraryLocalizations l10n,
    ) {
  switch (disputeStatus) {
    case DisputeStatus.pendingReview:
      return l10n.pendingReviewDisputeStatus;
    case DisputeStatus.chargedBack:
      return l10n.chargedBackDisputeStatus;
    case DisputeStatus.denied:
      return l10n.deniedDisputeStatus;
  }
}