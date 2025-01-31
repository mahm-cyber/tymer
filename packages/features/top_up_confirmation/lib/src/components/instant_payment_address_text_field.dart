import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:top_up_confirmation/src/l10n/top_up_confirmation_localizations.dart';
import 'package:top_up_confirmation/src/top_up_confirmation_cubit.dart';

class InstantPaymentAddressTextField extends StatefulWidget {
  const InstantPaymentAddressTextField({super.key});

  @override
  State<InstantPaymentAddressTextField> createState() => 
      _InstantPaymentAddressTextFieldState();
}

class _InstantPaymentAddressTextFieldState 
    extends State<InstantPaymentAddressTextField> {
  final _addressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpAddressFieldFocusListener();
  }

  void _setUpAddressFieldFocusListener() {
    final cubit = context.read<TopUpConfirmationCubit>();
    _addressFocusNode.addListener(() {
      if (!_addressFocusNode.hasFocus) {
        cubit.onInstantPaymentAddressUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _addressFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpConfirmationCubit, TopUpConfirmationState>(
      builder: (context, state) {
        final cubit = context.read<TopUpConfirmationCubit>();
        final addressError = 
            state.instantPaymentAddress.isNotValid ? 
            state.instantPaymentAddress.error : null;
        final isSubmissionInProgress = 
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final l10n = TopUpConfirmationLocalizations.of(context);

        return TextFormField(
          enabled: !isSubmissionInProgress,
          focusNode: _addressFocusNode,
          onChanged: cubit.onInstantPaymentAddressChanged,
          decoration: InputDecoration(
            isDense: true,
            labelText: l10n.instantPaymentAddressTextFieldLabel,
            prefixIcon: const SvgAsset(
              AssetPathConstants.bankNoteBlackPath,
            ),
            hintText: l10n.instantPaymentAddressTextFieldLabel,
            errorText: addressError == DynamicValidationError.empty
                ? l10n.requiredFieldErrorMessage
                : null,
          ),
        );
      },
    );
  }
} 