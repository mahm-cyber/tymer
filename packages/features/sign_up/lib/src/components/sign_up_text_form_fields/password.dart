import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:sign_up/src/sign_up_cubit.dart';

class Password extends StatefulWidget {
  const Password({
    super.key,
  });

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignUpCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onPasswordUnfocused();
      } else {
        cubit.onPasswordFocused();
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
        final cubit = context.read<SignUpCubit>();
        final passwordError =
            state.password.isNotValid ? state.password.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final theme = TymerTheme.of(context);

        return TextField(
          textInputAction: TextInputAction.next,
          focusNode: _focusNode,
          onChanged: cubit.onPasswordChanged,
          enabled: !isSubmissionInProgress,
          decoration: InputDecoration(
            prefixIcon: GestureDetector(
              onTap: () {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                Offset position = renderBox.localToGlobal(Offset.zero);
                _focusNode.unfocus();
                cubit.togglePasswordInfoOverlay(position.dy);
              },
              child: Icon(
                Icons.info_outline,
                size: 30,
                color: theme.iconColor,
              ),
            ),
            errorText: passwordError == PasswordValidationError.empty
                ? 'مطلوب*'
                : passwordError == PasswordValidationError.weak
                    ? 'كلمة المرور ضعيفه'
                    : passwordError ==
                            PasswordValidationError.invalidCredentials
                        ? 'البريد الالكترونى أو كلمة المرور خطأ'
                        : null,
          ),
        );
      },
    );
  }
}
