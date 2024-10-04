import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forgot_password/src/components/phone_text_field.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:forgot_password/src/components/forgot_password_button.dart';
import 'package:forgot_password/src/l10n/forgot_password_localizations.dart';

import 'package:forgot_password/src/forgot_password_cubit.dart';
import 'package:user_repository/user_repository.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({
    required this.userRepository,
    required this.onForgotPasswordSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onForgotPasswordSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotPasswordCubit>(
      create: (_) => ForgotPasswordCubit(
        userRepository: userRepository,
      ),
      child: ForgotPasswordView(
        onForgotPasswordSuccess: onForgotPasswordSuccess,
      ),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({
    super.key,
    required this.onForgotPasswordSuccess,
  });

  final VoidCallback onForgotPasswordSuccess;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = ForgotPasswordLocalizations.of(context);
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.otpSentSuccessfullySnackBarMessage,
            ),
          );
          onForgotPasswordSuccess();
          return;
        }
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.generalErrorSnackBarMessage,
            ),
          );
          return;
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.releaseFocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.appBarTitle),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
              children: [
                VerticalGap.large(),
                const PhoneTextField(),
                VerticalGap.xxLarge(),
                const ForgotPasswordButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
