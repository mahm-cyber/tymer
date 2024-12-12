import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_up/src/l10n/sign_up_localizations.dart';

import 'package:sign_up/src/sign_up_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

import 'components/components.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    required this.userRepository,
    required this.onSignInTap,
    required this.onSignUpSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onSignInTap;
  final VoidCallback onSignUpSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) => SignUpCubit(
        userRepository: userRepository,
      ),
      child: SignUpView(
        onSignInTap: onSignInTap,
        onSignUpSuccess: onSignUpSuccess,
      ),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({
    super.key,
    required this.onSignUpSuccess,
    required this.onSignInTap,
  });

  final VoidCallback onSignUpSuccess;
  final VoidCallback onSignInTap;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        final l10n = SignUpLocalizations.of(context);
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.signUpSuccessMessage,
            ),
          );
          onSignUpSuccess();
          return;
        }
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.signUpFailureMessage,
            ),
          );
          return;
        }
      },
      builder: (context, state) {
        final theme = TymerTheme.of(context);
        final l10n = SignUpLocalizations.of(context);
        final colorScheme = Theme.of(context).colorScheme;

        return GestureDetector(
          onTap: () {
            context.releaseFocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.appBarTitle),
              backgroundColor: colorScheme.surface,
            ),            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.screenMargin * 2),
              child: Column(
                children: [
                  const SvgAsset(
                    AssetPathConstants.logoAndWordPath,
                    width: 60,
                  ),
                  const FormFields(),
                  const TermsAndConditions(),
                  VerticalGap.medium(),
                  const SignUpButton(),
                  VerticalGap.medium(),
                  GoToSignIn(onTap: onSignInTap),
                  VerticalGap.medium(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

