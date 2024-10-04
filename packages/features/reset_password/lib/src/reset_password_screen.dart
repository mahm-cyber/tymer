import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:reset_password/src/components/change_password_button.dart';
import 'package:reset_password/src/components/components.dart';
import 'package:reset_password/src/l10n/reset_password_localizations.dart';
import 'package:reset_password/src/reset_password_cubit.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    required this.userRepository,
    required this.onBackTapped,
    required this.onResetPasswordSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onBackTapped;
  final VoidCallback onResetPasswordSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ResetPasswordCubit>(
      create: (_) => ResetPasswordCubit(
        userRepository: userRepository,
      ),
      child: ResetPasswordView(
        onBackTapped: onBackTapped,
        onResetPasswordSuccess: onResetPasswordSuccess,
      ),
    );
  }
}

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({
    super.key,
    required this.onBackTapped,
    required this.onResetPasswordSuccess,
  });

  final VoidCallback onBackTapped;
  final VoidCallback onResetPasswordSuccess;

  @override
  Widget build(BuildContext context) {
    final l10n = ResetPasswordLocalizations.of(context);
    final theme = TymerTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.resetPasswordSuccessMessage,
            ),
          );
          onResetPasswordSuccess();
          return;
        }
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: 'حدث خطأ ما',
            ),
          );
          return;
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: context.releaseFocus,
          child: Scaffold(
            appBar: AppBar(),
            body: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: theme.screenMargin,
              ),
              children: [
                VerticalGap.xLarge(),
                Text(
                  l10n.resetPasswordScreenTitle,
                  style: textTheme.headlineSmall,
                ),
                VerticalGap.medium(),
                Text(
                  l10n.resetPasswordScreenSubtitle,
                  style: textTheme.bodyMedium,
                ),
                VerticalGap.medium(),
                NewPassword(),
                VerticalGap.medium(),
                NewPasswordConfirmation(),
                VerticalGap.xLarge(),
                const ResetPasswordButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
