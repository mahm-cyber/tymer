import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:forgot_password/src/l10n/forgot_password_localizations.dart';

import 'package:forgot_password/src/forgot_password_cubit.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final cubit = context.read<ForgotPasswordCubit>();
        // final theme = TymerkTheme.of(context);
        final l10n = ForgotPasswordLocalizations.of(context);
        return isSubmissionInProgress
            ? TymerElevatedButton.inProgress(
                label: l10n.forgotPasswordProgressButtonLabel,
              )
            : TymerElevatedButton(
                onTap: cubit.onSubmit,
                label: l10n.forgotPasswordButtonLabel,
              );
      },
    );
  }
}
