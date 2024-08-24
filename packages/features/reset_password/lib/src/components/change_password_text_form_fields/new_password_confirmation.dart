import 'package:reset_password/src/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

class NewPasswordConfirmation extends StatefulWidget {
  const NewPasswordConfirmation({
    super.key,
  });

  @override
  State<NewPasswordConfirmation> createState() =>
      _NewPasswordConfirmationState();
}

class _NewPasswordConfirmationState extends State<NewPasswordConfirmation> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ResetPasswordCubit>();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        cubit.onNewPasswordConfirmationUnfocused();
      } else {
        cubit.onNewPasswordConfirmationFocused();
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
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        final error = state.newPasswordConfirmation.isNotValid
            ? state.newPasswordConfirmation.error
            : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        // final theme = TymerTheme.of(context);
        final cubit = context.read<ResetPasswordCubit>();
        return TextField(
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'تاكيد كلمة المرور الجديده',
            errorText: error == PasswordConfirmationValidationError.empty
                ? 'مطلوب*'
                : error == PasswordConfirmationValidationError.doesNotMatch
                    ? 'كلمة مرور غير مطابفه'
                    : null,
          ),
          onChanged: cubit.onNewPasswordConfirmationChanged,
          enabled: !isSubmissionInProgress,
          onEditingComplete: cubit.onSubmit,
        );
      },
    );
  }
}
