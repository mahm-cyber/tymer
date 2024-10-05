import 'package:form_fields/form_fields.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationServiceTypePicker extends StatelessWidget {
  const ReservationServiceTypePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
    final isArabic = currentLocale.languageCode == 'ar';
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final cubit = context.read<RequestServiceCubit>();
        final theme = TymerTheme.of(context);
        final textTheme = Theme.of(context).textTheme;
        final reservationServiceTypeError =
            state.selectedReservationServiceType.isNotValid
                ? state.selectedReservationServiceType.error
                : null;
        final l10n = RequestServiceLocalizations.of(context);
        return SizedBox(
          height: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final serviceType = state.reservationServiceTypes![index];
                    final isSelected =
                        state.selectedReservationServiceType.value?.id ==
                            serviceType.id;
                    return Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: index == 0 ? theme.screenMargin : 0,
                        end: index == state.reservationServiceTypes!.length
                            ? theme.screenMargin
                            : Spacing.medium,
                      ),
                      child: ChoiceChip(
                        side: reservationServiceTypeError ==
                                DynamicValidationError.empty
                            ? BorderSide(color: theme.errorColor)
                            : null,
                        checkmarkColor:
                            theme.materialThemeData.colorScheme.surface,
                        label: Text(
                          isArabic ? serviceType.name.ar : serviceType.name.en,
                          style: textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? theme.materialThemeData.colorScheme.surface
                                : null,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        selected: isSelected,
                        onSelected: (_) {
                          cubit.serviceTypeSelected(serviceType);
                        },
                      ),
                    );
                  },
                  itemCount: state.reservationServiceTypes!.length,
                ),
              ),
              VerticalGap.xSmall(),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: theme.screenMargin + Spacing.medium,
                ),
                child: Text(
                  textAlign: TextAlign.start,
                  reservationServiceTypeError == DynamicValidationError.empty
                      ? l10n.requiredFieldErrorMessage
                      : '',
                  style: textTheme.bodySmall?.copyWith(
                    color: theme.errorColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
