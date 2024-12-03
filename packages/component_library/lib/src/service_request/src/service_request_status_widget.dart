import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ServiceRequestStatusWidget extends StatelessWidget {
  const ServiceRequestStatusWidget({
    super.key,
    required this.service,
  });

  final Service service;

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
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
          color: service.status?.color ?? Colors.black,
        ),
      ),
      child: Text(
        serviceRequestStatusToLocalizedString(service.status!, l10n),
        style: textTheme.bodyMedium?.copyWith(
          color: service.status?.color ?? Colors.black,
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
