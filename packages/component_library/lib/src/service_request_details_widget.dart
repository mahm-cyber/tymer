import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class ServiceRequestDetailsWidget extends StatelessWidget {
  const ServiceRequestDetailsWidget({
    super.key,
    required this.service,
    required this.onViewServiceOnMap,
    this.physics,
  });

  final Service service;
  final VoidCallback onViewServiceOnMap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    final serviceDetails = service.requestDetails;
    final hasEitherDate =
        serviceDetails?.date != null || serviceDetails?.reservationDate != null;
    final date = hasEitherDate
        ? serviceDetails?.date ?? serviceDetails?.reservationDate
        : null;
    final hasEitherTime =
        serviceDetails?.time != null || serviceDetails?.reservationTime != null;
    final time = hasEitherTime
        ? serviceDetails?.time ?? serviceDetails?.reservationTime
        : null;
    final theme = TymerTheme.of(context);
    final l10n = ComponentLibraryLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final locale = Localizations.localeOf(context);
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
      physics: physics,
      shrinkWrap: true,
      children: [
        VerticalGap.small(),
        if (service.id != null) ...[
          TextFormField(
            enableInteractiveSelection: true,
            initialValue: service.id.toString(),
            enabled: false,
            decoration: InputDecoration(
              labelText: l10n.serviceIdTextFieldLabel,
              prefixIcon: const Icon(Icons.tag),
            ),
          ),
          VerticalGap.small(),
        ],
        if (serviceDetails?.reservationServiceCategory != null) ...[
          TextFormField(
            enableInteractiveSelection: true,
            initialValue: isArabic
                ? serviceDetails!.reservationServiceCategory!.name.ar
                : serviceDetails!.reservationServiceCategory!.name.en,
            enabled: false,
            decoration: InputDecoration(
              labelText: l10n.reservationServiceCategoryTextFieldLabel,
              prefixIcon: const Icon(Icons.category_outlined),
            ),
          ),
          VerticalGap.small(),
        ],
        if (serviceDetails?.reservedFor != null) ...[
          TextFormField(
            enableInteractiveSelection: true,
            initialValue: serviceDetails!.reservedFor,
            enabled: false,
            decoration: InputDecoration(
              labelText: l10n.reservedForTextFieldLabel,
              prefixIcon: const SvgAsset(
                AssetPathConstants.personBlackPath,
              ),
            ),
          ),
          VerticalGap.small(),
        ],
        if (hasEitherDate) ...[
          TextFormField(
            enableInteractiveSelection: true,
            initialValue: (date!.toIso8601String().split('T').first)
                .localizeDateString(locale),
            enabled: false,
            decoration: InputDecoration(
              labelText: l10n.dateTextFieldLabel,
              prefixIcon: const SvgAsset(
                AssetPathConstants.calendarPath,
              ),
            ),
          ),
          VerticalGap.small(),
        ],
        if (hasEitherTime) ...[
          TextFormField(
            enableInteractiveSelection: true,
            initialValue: time!.localizedTimeOfDay(locale),
            enabled: false,
            decoration: InputDecoration(
              labelText: l10n.timeTextFieldLabel,
              prefixIcon: const Icon(Icons.calendar_today),
            ),
          ),
          VerticalGap.small(),
        ],
        TextFormField(
          enableInteractiveSelection: true,
          initialValue: serviceDetails?.placeName,
          enabled: false,
          decoration: InputDecoration(
            labelText: l10n.placeNameTextFieldLabel,
            prefixIcon: const Icon(
              Icons.info_outline,
            ),
          ),
        ),
        VerticalGap.small(),
        TextFormField(
          enableInteractiveSelection: true,
          initialValue: serviceDetails?.placeAddress,
          enabled: false,
          decoration: InputDecoration(
            labelText: l10n.placeAddressTextFieldLabel,
            prefixIcon: const SvgAsset(
              AssetPathConstants.streetSignPath,
            ),
          ),
        ),
        VerticalGap.small(),
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
                    width: MediaQuery.of(context).size.width/2.5 -
                        (2 * theme.screenMargin)
                        ,
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
        VerticalGap.small(),
        TextFormField(
          enableInteractiveSelection: true,
          initialValue:
              '${service.price!.localizeDouble(locale)} ${l10n.eyptianPoundLetters}',
          enabled: false,
          decoration: InputDecoration(
            labelText: l10n.priceTextFieldLabel,
            prefixIcon: const SvgAsset(
              AssetPathConstants.bankNoteBlackPath,
            ),
          ),
        ),
        VerticalGap.small(),
        if (serviceDetails?.additionalComments != null)
          TextFormField(
            enableInteractiveSelection: true,
            initialValue: serviceDetails?.additionalComments,
            enabled: false,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: l10n.additionalCommentsTextFieldLabel,
      
            ),
          ),
      ],
    );
  }
}

class ServiceRequestDetailsExpansionTile extends StatelessWidget {
  const ServiceRequestDetailsExpansionTile({
    super.key,
    required this.service,
    required this.onViewServiceOnMap,
  });

  final Service service;
  final VoidCallback onViewServiceOnMap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final l10n = ComponentLibraryLocalizations.of(context);

    return ExpansionTile(
      title: Text(
        l10n.serviceRequestDetailsTileTitle,
        style: textTheme.titleMedium,
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: colorScheme.secondary,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: colorScheme.secondary,
        ),
      ),
      children: [
        ServiceRequestDetailsWidget(
          service: service,
          onViewServiceOnMap: onViewServiceOnMap,
          physics: const NeverScrollableScrollPhysics(),
        ),
        VerticalGap.medium(),
      ],
    );
  }
}
