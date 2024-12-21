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
        final reservationServiceTypeError =
            state.selectedReservationServiceType.isNotValid
                ? state.selectedReservationServiceType.error
                : null;
        final l10n = RequestServiceLocalizations.of(context);
        final loadingReservationTypes = state.reservationServiceTypes == null ||
            state.fetchingReservationServiceTypesStatus ==
                FetchingReservationServiceTypesStatus.inProgress;
        return Padding(
          padding: EdgeInsets.only(
            left: theme.screenMargin,
            right: theme.screenMargin,
          ),
          child: loadingReservationTypes
              ? const LoadingInputField()
              : DropdownButtonFormField<int>(
                  value: state.selectedReservationServiceType.value?.id,
                  onChanged: (selectedId) {
                    final selectedServiceType = state.reservationServiceTypes!
                        .firstWhere(
                            (serviceType) => serviceType.id == selectedId);
                    cubit.serviceTypeSelected(selectedServiceType);
                  },
                  decoration: InputDecoration(
                    labelText: l10n.selectServiceTypeLabel,
                    errorText: reservationServiceTypeError ==
                            DynamicValidationError.empty
                        ? l10n.requiredFieldErrorMessage
                        : null,
                    border: const OutlineInputBorder(),
                  ),
                  items: state.reservationServiceTypes!
                      .map<DropdownMenuItem<int>>((serviceType) {
                    return DropdownMenuItem<int>(
                      value: serviceType.id,
                      child: Text(
                        isArabic ? serviceType.name.ar : serviceType.name.en,
                      ),
                    );
                  }).toList(),
                ),
        );
      },
    );
  }
}
