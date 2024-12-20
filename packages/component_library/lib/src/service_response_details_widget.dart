import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class ServiceResponseDetailsWidget extends StatelessWidget {
  const ServiceResponseDetailsWidget({
    super.key,
    required this.service,
    this.physics = const NeverScrollableScrollPhysics(),
    required this.userToken,
  });

  final Service service;
  final ScrollPhysics? physics;
  final String userToken;

  @override
  Widget build(BuildContext context) {
    final response = service.responseDetails;
    final hasReservationNumber = response?.reservationNumber != null;
    final hasDate = response?.date != null;
    final hasTime = response?.time != null;
    final hasAdditionalNotes = response?.additionalNotes != null;
    final hasImageUrl = response?.imageUrl != null;
    final theme = TymerTheme.of(context);
    final l10n = ComponentLibraryLocalizations.of(context);
    final colorScheme = theme.materialThemeData.colorScheme;
    final locale = Localizations.localeOf(context);
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
      physics: physics,
      shrinkWrap: true,
      children: [
        if (hasReservationNumber) ...[
          VerticalGap.medium(),
          TextFormField(
            enabled: false,
            initialValue: response!.reservationNumber.toString(),
            decoration: InputDecoration(
              labelText: l10n.reservationNumberTextFieldLabel,
              prefixIcon: const Icon(
                Icons.numbers,
              ),
            ),
          ),
        ],
        if (hasDate) ...[
          VerticalGap.medium(),
          TextFormField(
            enabled: false,
            initialValue: (response!.date!.toIso8601String().split('T').first)
                .localizeDateString(locale),
            decoration: InputDecoration(
              labelText: l10n.dateTextFieldLabel,
              prefixIcon: const Icon(
                Icons.calendar_today,
              ),
            ),
          ),
        ],
        if (hasTime) ...[
          VerticalGap.medium(),
          TextFormField(
            enabled: false,
            initialValue: response!.time!.localizedTimeOfDay(locale),
            decoration: InputDecoration(
              labelText: l10n.timeTextFieldLabel,
              prefixIcon: const Icon(
                Icons.access_time,
              ),
            ),
          ),
        ],
        if (hasImageUrl) ...[
          VerticalGap.medium(),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border.all(color: theme.borderColor),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  isSelected: true,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      content: InteractiveViewer(
                        child: Image.network(
                          response!.imageUrl!,
                          headers: {
                            "Authorization": "Bearer $userToken",
                            "X-API-Key":
                                const String.fromEnvironment('x-api-key'),
                          },
                        ),
                      ),
                    ),
                  ),
                  icon: const Icon(
                    Icons.image_outlined,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        ],
        if (hasAdditionalNotes) ...[
          VerticalGap.medium(),
          TextFormField(
            enabled: false,
            maxLines: 4,
            initialValue: response!.additionalNotes,
            decoration: InputDecoration(
              labelText: l10n.additionalNotesTextFieldLabel,
              prefixIcon: const Icon(
                Icons.notes,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class ServiceResponseDetailsExpansionTile extends StatelessWidget {
  const ServiceResponseDetailsExpansionTile({
    super.key,
    required this.service,
    required this.userToken,
  });

  final Service service;
  final String userToken;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final l10n = ComponentLibraryLocalizations.of(context);

    return ExpansionTile(
      title: Text(
        l10n.serviceResponseDetailsTileTitle,
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
        ServiceResponseDetailsWidget(
          service: service,
          physics: const NeverScrollableScrollPhysics(),
          userToken: userToken,
        ),
        VerticalGap.medium(),
      ],
    );
  }
}
