import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:sign_up/src/sign_up_cubit.dart';

class Email extends StatefulWidget {
  const Email({
    super.key,
  });

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignUpCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onEmailUnfocused();
      } else {
        cubit.onEmailFocused();
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
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      final cubit = context.read<SignUpCubit>();
      final emailError = state.email.isNotValid ? state.email.error : null;
      final isSubmissionInProgress =
          state.submissionStatus == FormzSubmissionStatus.inProgress;
      // final theme = TymerTheme.of(context);
      return TextField(
        enabled: !isSubmissionInProgress,
        focusNode: _focusNode,
        onChanged: cubit.onEmailChanged,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'البريد الإلكتروني',
          hintText: '',
          helperText: '',
          errorText: emailError == EmailValidationError.empty
              ? 'مطلوب*'
              : emailError == EmailValidationError.invalidCredentials
                  ? 'البريد الالكترونى أو كلمة المرور خطأ'
                  : emailError == EmailValidationError.invalidFormat
                      ? 'صيغة البريد الالكترونى غير صالحة'
                      : emailError == EmailValidationError.alreadyRegistered
                          ? 'البريد الالكترونى أو رقم الجوال لدينا بالفعل'
                          : null,
        ),
      );
    });
  }
}
