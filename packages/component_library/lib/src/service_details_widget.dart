import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class ServiceDetailsWidget extends StatelessWidget {
  const ServiceDetailsWidget({
    super.key,
    required this.service,
    required this.onViewServiceOnMap,
  });

  final Service service;
  final VoidCallback onViewServiceOnMap;

  @override
  Widget build(BuildContext context) {
    final serviceDetails = service.details;
    final theme = TymerTheme.of(context);
    final l10n = ComponentLibraryLocalizations.of(context);
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
      shrinkWrap: true,
      children: [
        VerticalGap.small(),
        if (serviceDetails.reservedFor != null) ...[
          TextFormField(
            enableInteractiveSelection: true,
            initialValue: serviceDetails.reservedFor,
            enabled: false,
            decoration: InputDecoration(
              labelText: l10n.reservedForTextFieldLabel,
              prefixIcon: const SvgAsset(
                AssetPathConstants.personBlackPath,
              ),
            ),
          ),
          VerticalGap.medium(),
        ],

        TextFormField(
          enableInteractiveSelection: true,
          initialValue: service.createdAt?.toIso8601String().split('T').first,
          enabled: false,
          decoration: InputDecoration(
              labelText: l10n.dateTextFieldLabel,
              prefixIcon: const SvgAsset(
                AssetPathConstants.calendarPath,
              )),
        ),
        VerticalGap.medium(),
        TextFormField(
          enableInteractiveSelection: true,
          initialValue: serviceDetails.placeName,
          enabled: false,
          decoration: InputDecoration(
            labelText: l10n.placeNameTextFieldLabel,
            prefixIcon: const Icon(
              Icons.info_outline,
            ),
          ),
        ),
        VerticalGap.medium(),
        TextFormField(
          enableInteractiveSelection: true,
          initialValue: serviceDetails.placeAddress,
          enabled: false,
          decoration: InputDecoration(
            labelText: l10n.placeAddressTextFieldLabel,
            prefixIcon: const SvgAsset(
              AssetPathConstants.streetSignPath,
            ),
          ),
        ),
        VerticalGap.medium(),
        GestureDetector(
          onTap: onViewServiceOnMap,
          child: Stack(
            children: [
              TextFormField(
                enableInteractiveSelection: true,
                enabled: false,
                decoration: InputDecoration(
                  labelText: l10n.locationTextFieldLabel,
                  prefixIcon: const SvgAsset(
                    AssetPathConstants.locationPath,
                  ),
                ),
              ),
              PositionedDirectional(
                end: Spacing.large,
                top: 7.5,
                child: AbsorbPointer(
                  child: TymerElevatedButton(
                    label: l10n.viewOnMapButtonLabel,
                    onTap: () {},
                    width: MediaQuery.of(context).size.width -
                        (2 * theme.screenMargin) -
                        230,
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
        VerticalGap.medium(),
        TextFormField(
          enableInteractiveSelection: true,
          initialValue: '${service.price.toStringAsFixed(0)} EGP',
          enabled: false,
          decoration: InputDecoration(
            labelText: l10n.priceTextFieldLabel,
            prefixIcon: const SvgAsset(
              AssetPathConstants.bankNoteBlackPath,
            ),
          ),
        ),
        VerticalGap.medium(),
        if (serviceDetails.additionalComments != null)
          TextFormField(
            enableInteractiveSelection: true,
            initialValue: serviceDetails.additionalComments,
            enabled: false,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: l10n.additionalCommentsTextFieldLabel,
              // prefixIcon: const SvgAsset(
              //   AssetPathConstants.chatPath,
              // ),
            ),
          ),
      ],
    );
  }
}
