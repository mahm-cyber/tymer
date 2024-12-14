import 'package:component_library/component_library.dart';
import 'package:form_fields/form_fields.dart';
import 'package:request_service/src/l10n/request_service_localizations.dart';
import 'package:request_service/src/request_service_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressTextField extends StatefulWidget {
  const AddressTextField({
    super.key,
  });

  @override
  State<AddressTextField> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
  final _addressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpAddressFieldFocusListener();
  }

  void _setUpAddressFieldFocusListener() {
    final cubit = context.read<RequestServiceCubit>();
    _addressFocusNode.addListener(() {
      if (!_addressFocusNode.hasFocus) {
        cubit.onAddressUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestServiceCubit, RequestServiceState>(
      builder: (context, state) {
        final cubit = context.read<RequestServiceCubit>();
        final l10n = RequestServiceLocalizations.of(context);
        final addressError =
            state.address.isNotValid ? state.address.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final theme = TymerTheme.of(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
          child: TextField(
            enabled: !isSubmissionInProgress,
            focusNode: _addressFocusNode,
            onChanged: cubit.onAddressChanged,
            decoration: InputDecoration(
              labelText: l10n.addressTextFieldLabel,
              hintText: l10n.addressTextFieldLabel,
              errorText: addressError == DynamicValidationError.empty
                  ? l10n.requiredFieldErrorMessage
                  : null,
            ),
          ),
        );
      },
    );
  }
}
