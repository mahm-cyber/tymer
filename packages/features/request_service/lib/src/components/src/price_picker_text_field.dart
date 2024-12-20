import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';

class PricePickerTextField extends StatelessWidget {
  const PricePickerTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<RequestServiceCubit>();
        final l10n = RequestServiceLocalizations.of(context);
        final clL10n = ComponentLibraryLocalizations.of(context);
        final locale = Localizations.localeOf(context);
        final theme = TymerTheme.of(context);
        final colorScheme = theme.materialThemeData.colorScheme;
        final minPrice = state.serviceType == ServiceType.other
            ? state.pricingSettings!.otherServiceMinPrice
            : state.pricingSettings!.reservationServiceMinPrice;
        final loadingPricing = state.fetchingPricingSettingsStatus ==
            FetchingPricingSettingsStatus.inProgress;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
          child: loadingPricing
              ? SizedBox(
                  height: 55,
                  child: LinearProgressIndicator(
                    color: Colors.grey.withAlpha((255 * 0.3).toInt()),
                    backgroundColor: Colors.white,
                  ),
                )
              : TextField(
                  controller: TextEditingController(
                    text:
                        '${state.price!.localizeDouble(locale)} ${clL10n.eyptianPoundLetters}',
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 24,
                        color: colorScheme.onSurface,
                      ),
                      onPressed: isSubmissionInProgress
                          ? null
                          : cubit.onIncrementPrice,
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                        size: 24,
                        color: state.price! <= minPrice ? Colors.grey : null,
                      ),
                      onPressed:
                          state.price! <= minPrice || isSubmissionInProgress
                              ? null
                              : cubit.onDecrementPrice,
                    ),
                    labelText: l10n.pricePickerTextFieldLabel,
                  ),
                  readOnly: true,
                ),
        );
      },
    );
  }
}
