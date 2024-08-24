import 'package:reset_password/src/reset_password_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';





class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<ResetPasswordCubit>();
        // final theme = TymerTheme.of(context);

        return isSubmissionInProgress
            ? TymerElevatedButton.inProgress(
                label: 'جارى الحفظ',
              )
            : TymerElevatedButton(
                onTap: cubit.onSubmit,
                label: 'حفظ',
              );
      },
    );
  }
}

