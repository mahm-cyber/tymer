import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forgot_password/src/forgot_password_cubit.dart';
import 'package:forgot_password/src/l10n/forgot_password_localizations.dart';
import 'package:form_fields/form_fields.dart';

class PhoneTextField extends StatefulWidget {
  const PhoneTextField({
    super.key,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final _phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setUpEmailFieldFocusListener();
  }

  void _setUpEmailFieldFocusListener() {
    final cubit = context.read<ForgotPasswordCubit>();
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        cubit.onMobileUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) {
      final cubit = context.read<ForgotPasswordCubit>();
      final phoneError = state.phone.isNotValid ? state.phone.error : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      final l10n = ForgotPasswordLocalizations.of(context);

      return TextField(
        enabled: !isSubmissionInProgress,
        focusNode: _phoneFocusNode,
        onChanged: cubit.onMobileChanged,
        onEditingComplete: cubit.onSubmit,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          isDense: true,
          labelText: l10n.phoneTextFieldLabel,
          prefixIcon: const SvgAsset(
            AssetPathConstants.mobilePath,
          ),

          hintText: l10n.phoneTextFieldLabel,
          errorText: phoneError == MobileValidationError.empty
              ? l10n.requiredFieldErrorMessage
              : phoneError == MobileValidationError.isNotRegistered
                  ? l10n.isNotRegisteredErrorMessage
                  : phoneError == MobileValidationError.invalidFormat
                      ? l10n.invalidPhoneFormatErrorMessage
                      : phoneError == MobileValidationError.unverified
                          ? l10n.unverifiedPhoneErrorMessage
                          : null,
        ),
      );
    });
  }
}
