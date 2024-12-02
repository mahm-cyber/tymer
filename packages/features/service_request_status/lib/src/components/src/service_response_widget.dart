import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_request_status/src/l10n/service_request_status_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:service_request_status/src/service_request_status_cubit.dart';

class ServiceResponseWidget extends StatelessWidget {
  const ServiceResponseWidget({
    super.key,
    this.response,
  });

  final ServiceResponse? response;

  @override
  Widget build(BuildContext context) {
    final hasReservationNumber = response?.reservationNumber != null;
    final hasDate = response?.date != null;
    final hasTime = response?.time != null;
    final hasAdditionalNotes = response?.additionalNotes != null;
    final hasImageUrl = response?.imageUrl != null;
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final l10n = ServiceRequestStatusLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final theme = TymerTheme.of(context);
    final cubit = context.read<ServiceRequestStatusCubit>();
    return BlocBuilder<ServiceRequestStatusCubit, ServiceRequestStatusState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  VerticalGap.xLarge(),
                  VerticalGap.mediumLarge(),
                  if (hasReservationNumber) ...[
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
                      initialValue:
                          response!.date!.toIso8601String().split('T').first,
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
                      initialValue: response!.time!.twelveHrFormat,
                      decoration: InputDecoration(
                        labelText: l10n.timeTextFieldLabel,
                        prefixIcon: const Icon(
                          Icons.access_time,
                        ),
                      ),
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
                                contentPadding:  EdgeInsets.zero,

                                content: InteractiveViewer(
                                  child: Image.network(
                                    response!.imageUrl!,
                                    headers: {
                                      "Authorization": "Bearer ${state.userToken}",
                                      "X-API-Key": "01f64a264be7442a9008abda93d5d6ae",
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
                ],
              ),
            ),
            VerticalGap.medium(),
            Container(
              padding: const EdgeInsets.all(Spacing.medium),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: Column(
                children: [
                  Text(
                    l10n.requestDoneContainerTitle,
                    style: textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  VerticalGap.medium(),
                  Row(
                    children: [
                      VerticalGap.medium(),
                      state.confirmationStatus == ConfirmationStatus.loading
                          ? Expanded(
                            child: TymerElevatedButton.inProgress(
                                label: l10n.yesButtonLabel,
                              ),
                          )
                          : Expanded(
                            child: TymerElevatedButton(
                                label: l10n.yesButtonLabel,
                                onTap: cubit.confirmService,
                              ),
                          ),
                      HorizontalGap.medium(),
                      Expanded(
                        child: TymerElevatedButton(
                          label: l10n.noButtonLabel,
                          onTap: () {},
                          bgColor: colorScheme.error,
                        ),
                      ),
                    ].reversed.toList(),
                  ),
                ],
              ),
            ),
            VerticalGap.medium(),
          ],
        );
      },
    );
  }
}
