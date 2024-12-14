import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
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
        final theme = TymerTheme.of(context);
        final colorScheme = theme.materialThemeData.colorScheme;
        final minPrice = state.serviceType == ServiceType.other
            ? state.pricingSettings!.otherServiceMinPrice
            : state.pricingSettings!.reservationServiceMinPrice;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
          child: TextField(
            controller: TextEditingController(
              text: '${state.price!.toStringAsFixed(0)} EGP',
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 24,
                  color: colorScheme.onSurface,
                ),
                onPressed:
                    isSubmissionInProgress ? null : cubit.onIncrementPrice,
              ),
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.remove_circle_outline,
                  size: 24,
                  color: state.price! <= minPrice ? Colors.grey : null,
                ),
                onPressed: state.price! <= minPrice || isSubmissionInProgress
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
