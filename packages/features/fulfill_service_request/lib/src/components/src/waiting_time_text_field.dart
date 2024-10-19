import 'package:component_library/component_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:fulfill_service_request/fulfill_service_request.dart';
import 'package:fulfill_service_request/src/fulfill_service_request_cubit.dart';

class WaitingTimeTextField extends StatefulWidget {
  const WaitingTimeTextField({
    super.key,
  });

  @override
  State<WaitingTimeTextField> createState() =>
      _WaitingTimeTextFieldState();
}

class _WaitingTimeTextFieldState
    extends State<WaitingTimeTextField> {
  final _waitingTimeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpWaitingTimeFieldFocusListener();
  }

  void _setUpWaitingTimeFieldFocusListener() {
    final cubit = context.read<FulfillServiceRequestCubit>();
    _waitingTimeFocusNode.addListener(() {
      if (!_waitingTimeFocusNode.hasFocus) {
        cubit.onWaitingTimeUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FulfillServiceRequestCubit, FulfillServiceRequestState>(
      builder: (context, state) {
        final cubit = context.read<FulfillServiceRequestCubit>();
        final l10n = FulfillServiceRequestLocalizations.of(context);
        final waitingTimeError = state.waitingTime.isNotValid
            ? state.waitingTime.error
            : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final theme = TymerTheme.of(context);
        return TextField(
          enabled: !isSubmissionInProgress,
          focusNode: _waitingTimeFocusNode,
          onChanged: cubit.onWaitingTimeChanged,
          decoration: InputDecoration(
            prefixIcon: const CupertinoActivityIndicator(animating: false,),
            labelText: l10n.waitingTimeTextFieldLabel,
            hintText: l10n.waitingTimeTextFieldLabel,
            errorText: waitingTimeError == DynamicValidationError.empty
                ? l10n.requiredFieldErrorMessage
                : null,
          ),
        );
      },
    );
  }
}
