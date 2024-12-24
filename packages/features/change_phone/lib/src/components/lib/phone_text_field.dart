import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:change_phone/src/l10n/change_phone_localizations.dart';
import 'package:change_phone/src/change_phone_cubit.dart';

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
    final cubit = context.read<ChangePhoneCubit>();
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        cubit.onPhoneUnfocused();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePhoneCubit, ChangePhoneState>(builder: (context, state) {
      final cubit = context.read<ChangePhoneCubit>();
      final phoneError = state.phone.isNotValid ? state.phone.error : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      final l10n = ChangePhoneLocalizations.of(context);

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
          hintText: l10n.phoneTextFieldHint,
          errorText: phoneError == MobileValidationError.empty
              ? l10n.requiredFieldErrorMessage
              : phoneError == MobileValidationError.invalidFormat
                      ? l10n.invalidPhoneFormatErrorMessage
                      : phoneError == MobileValidationError.isAlreadyRegistered
                          ? l10n.phoneIsAlreadyRegisteredErrorMessage
                          : null,
        ),
      );
    });
  }
}
