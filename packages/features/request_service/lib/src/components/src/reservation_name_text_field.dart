import 'package:component_library/component_library.dart';
import 'package:form_fields/form_fields.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationNameTextField extends StatefulWidget {
  const ReservationNameTextField({
    super.key,
  });

  @override
  State<ReservationNameTextField> createState() =>
      _ReservationNameTextFieldState();
}

class _ReservationNameTextFieldState extends State<ReservationNameTextField> {
  final _reservationNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpReservationNameFieldFocusListener();
  }

  void _setUpReservationNameFieldFocusListener() {
    final cubit = context.read<RequestServiceCubit>();
    _reservationNameFocusNode.addListener(() {
      if (!_reservationNameFocusNode.hasFocus) {
        cubit.onReservationNameUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final cubit = context.read<RequestServiceCubit>();
        final l10n = RequestServiceLocalizations.of(context);
        final reservationNameError = state.reservationName.isNotValid
            ? state.reservationName.error
            : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final theme = TymerTheme.of(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
          child: TextField(
            enabled: !isSubmissionInProgress,
            focusNode: _reservationNameFocusNode,
            onChanged: cubit.onReservationNameChanged,
            decoration: InputDecoration(
              labelText: l10n.reservationNameTextFieldLabel,
              hintText: l10n.reservationNameTextFieldLabel,
              errorText: reservationNameError == DynamicValidationError.empty
                  ? l10n.requiredFieldErrorMessage
                  : null,
            ),
          ),
        );
      },
    );
  }
}
