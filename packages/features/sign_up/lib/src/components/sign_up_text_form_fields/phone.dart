import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_up/src/l10n/sign_up_localizations.dart';

import 'package:sign_up/src/sign_up_cubit.dart';

class Phone extends StatefulWidget {
  const Phone({
    super.key,
  });

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignUpCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onPhoneUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final phoneError = state.phone.isNotValid ? state.phone.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        // final theme = TymerTheme.of(context);
        final l10n = SignUpLocalizations.of(context);
        final cubit = context.read<SignUpCubit>();
        return TextField(
          focusNode: _focusNode,
          onChanged: cubit.onPhoneChanged,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            prefixIcon: const SvgAsset(
              AssetPathConstants.mobilePath,
            ),
            hintText: l10n.phoneTextFieldHint,
            labelText: l10n.phoneTextFieldLabel,
            errorText: phoneError == MobileValidationError.empty
                ? l10n.requiredTextFieldErrorMessage
                : phoneError == MobileValidationError.invalidFormat
                    ? l10n.invalidMobileFormatErrorMessage
                    : phoneError == MobileValidationError.isAlreadyRegistered
                        ? l10n.alreadyRegisteredErrorMessage
                        : null,
          ),
          enabled: !isSubmissionInProgress,
        );
      },
    );
  }
}
