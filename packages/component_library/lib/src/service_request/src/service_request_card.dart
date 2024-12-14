import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class ServiceRequestCard extends StatelessWidget {
  const ServiceRequestCard({
    super.key,
    required this.onTapped,
    required this.service,
    this.dispute,
    this.shouldShowRequestStatus = false,
  });

  final VoidCallback onTapped;
  final Service service;
  final Dispute? dispute;
  final bool shouldShowRequestStatus;

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = theme.materialThemeData.colorScheme;
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.medium,
          vertical: Spacing.small,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width -
                      (2 * theme.screenMargin) -
                      170,
                  child: Text(
                    service.details!.reservedFor ?? service.details!.placeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (service.distanceBetweenProviderAndServiceLocation !=
                    null) ...[
                  VerticalGap.medium(),
                  Row(
                    children: [
                      const SvgAsset(
                        AssetPathConstants.footPrintFilledPath,
                      ),
                      HorizontalGap.medium(),
                      Text(
                        l10n.distanceToServiceLocation(
                          service.distanceBetweenProviderAndServiceLocation!
                              .toStringAsFixed(0),
                        ),
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
                //price
                VerticalGap.medium(),
                Row(
                  children: [
                    const SvgAsset(
                      AssetPathConstants.bankNotePath,
                    ),
                    HorizontalGap.medium(),
                    Text(
                      '${service.price!.toStringAsFixed(0)} EGP',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            if (shouldShowRequestStatus) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StatusWidget(
                    color: service.status?.color ?? Colors.black,
                    label: serviceRequestStatusToLocalizedString(
                        service.status!, l10n),
                  ),
                  if (dispute != null) ...[
                    VerticalGap.medium(),
                    StatusWidget(
                      color: dispute?.status.color ?? Colors.black,
                      label: disputeStatusToLocalizedString(dispute!.status, l10n),
                    ),
                  ],
                ],
              ),
              // StatusWidget(
              //   color: service.status?.color ?? Colors.black,
              //   label: serviceRequestStatusToLocalizedString(
              //       service.status!, l10n),
              // ),
            ],
            if (!shouldShowRequestStatus) ...[
              TymerElevatedButton(
                label: l10n.viewButtonLabel,
                onTap: onTapped,
                width: 120,
                height: 30,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
