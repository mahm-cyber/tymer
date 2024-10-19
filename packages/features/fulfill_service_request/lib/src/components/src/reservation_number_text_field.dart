import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:fulfill_service_request/src/fulfill_service_request_cubit.dart';

class ReservationNumberTextField extends StatefulWidget {
  const ReservationNumberTextField({
    super.key,
  });

  @override
  State<ReservationNumberTextField> createState() =>
      _ReservationNumberTextFieldState();
}

class _ReservationNumberTextFieldState
    extends State<ReservationNumberTextField> {
  final _reservationNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpReservationNumberFieldFocusListener();
  }
  void _setUpReservationNumberFieldFocusListener() {
    final cubit = context.read<FulfillServiceRequestCubit>();
    _reservationNumberFocusNode.addListener(() {
      if (!_reservationNumberFocusNode.hasFocus) {
        cubit.onReservationNumberUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FulfillServiceRequestCubit, FulfillServiceRequestState>(
      builder: (context, state) {
        final cubit = context.read<FulfillServiceRequestCubit>();
        final l10n = FulfillServiceRequestLocalizations.of(context);
        final reservationNumberError = state.reservationNumber.isNotValid
            ? state.reservationNumber.error
            : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final theme = TymerTheme.of(context);
        return TextField(

          enabled: !isSubmissionInProgress,
          focusNode: _reservationNumberFocusNode,
          onChanged: cubit.onReservationNumberChanged,
          decoration: InputDecoration(
            prefixIcon: const SvgAsset(AssetPathConstants.numberPath),
            labelText: l10n.reservationNumberTextFieldLabel,
            hintText: l10n.reservationNumberTextFieldLabel,
            errorText: reservationNumberError == DynamicValidationError.empty
                ? l10n.requiredFieldErrorMessage
                : null,
          ),
        );
      },
    );
  }
}
