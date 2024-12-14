import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_in/src/l10n/sign_in_localizations.dart';
import 'package:sign_in/src/sign_in_cubit.dart';

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
    _setUpPhoneFieldFocusListener();
  }

  void _setUpPhoneFieldFocusListener() {
    final cubit = context.read<SignInCubit>();
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        cubit.onPhoneUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
      final cubit = context.read<SignInCubit>();
      final phoneError = state.phone.isNotValid ? state.phone.error : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      final l10n = SignInLocalizations.of(context);

      return TextFormField(
        initialValue: state.rememberMe.phone,
        enabled: !isSubmissionInProgress,
        focusNode: _phoneFocusNode,
        onChanged: cubit.onPhoneChanged,
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
              : phoneError == MobileValidationError.invalidCredentials
                  ? l10n.invalidCredentialsErrorMessage
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
