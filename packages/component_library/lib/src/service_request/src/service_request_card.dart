import 'package:domain_models/domain_models.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class ServiceRequestCard extends StatelessWidget {
  const ServiceRequestCard({
    super.key,
    required this.onTapped,
    required this.service,
    this.disputeStatusWidget,
    this.shouldShowRequestStatus = false,
    this.height = 100,
    this.shouldShowId = false,
  });

  final VoidCallback onTapped;
  final Service service;
  final ServiceStatusWidget? disputeStatusWidget;
  final bool shouldShowRequestStatus;
  final double height;
  final bool shouldShowId;

  @override
  Widget build(BuildContext context) {
    final l10n = ComponentLibraryLocalizations.of(context);
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = theme.materialThemeData.colorScheme;
    final locale = Localizations.localeOf(context);
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        height: height,
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
                    service.requestDetails!.reservedFor ??
                        service.requestDetails!.placeName,
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
                              .localizeDouble(locale),
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
                const Spacer(),
                Row(
                  children: [
                    const SvgAsset(
                      AssetPathConstants.bankNotePath,
                    ),
                    HorizontalGap.medium(),
                    Text(
                      '${service.price!.localizeDouble(locale)} ${l10n.eyptianPoundLetters}',
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
                  if (disputeStatusWidget == null)
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 230,
                      ),
                      child: ServiceStatusWidget(
                        color: service.status?.color ?? Colors.black,
                        label: serviceRequestStatusToLocalizedString(
                          service.status!,
                          l10n,
                        ),
                      ),
                    ),
                  if (disputeStatusWidget != null) ...[
                    // const Spacer(),
                    disputeStatusWidget!,
                  ],
                  const Spacer(),
                  SelectableText(
                    '# ${service.id?.localizeInt(locale)}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // StatusWidget(
              //   color: service.status?.color ?? Colors.black,
              //   label: serviceRequestStatusToLocalizedString(
              //       service.status!, l10n),
              // ),
            ],
            if (!shouldShowRequestStatus) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TymerElevatedButton(
                    label: l10n.viewButtonLabel,
                    onTap: onTapped,
                    width: 120,
                    height: 30,
                  ),
                  const Spacer(),
                  if (shouldShowId)
                    SelectableText(
                      '# ${service.id?.localizeInt(locale)}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
