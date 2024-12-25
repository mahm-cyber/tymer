import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_in/sign_in.dart';
import 'package:sign_in/src/components/lib/phone_text_field.dart';
import 'package:sign_in/src/sign_in_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

import 'components/components.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
    required this.userRepository,
    required this.onSignInSuccess,
    required this.onUnverifiedSignIn,
    required this.onSignUpTapped,
    required this.onForgotPasswordTapped,
  });

  final UserRepository userRepository;
  final VoidCallback onSignInSuccess;
  final VoidCallback onUnverifiedSignIn;
  final VoidCallback onSignUpTapped;
  final VoidCallback onForgotPasswordTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (_) => SignInCubit(
        userRepository: userRepository,
        onUnverifiedSignIn: onUnverifiedSignIn,
        onSignUpTapped: onSignUpTapped,
        onForgotPasswordTapped: onForgotPasswordTapped,
      ),
      child: SignInView(
        onSignInSuccess: onSignInSuccess,
      ),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({
    required this.onSignInSuccess,
    super.key,
  });

  final VoidCallback onSignInSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.releaseFocus(),
      child: _SignInForm(
        onSignInSuccess: onSignInSuccess,
      ),
    );
  }
}

class _SignInForm extends StatelessWidget {
  const _SignInForm({
    required this.onSignInSuccess,
  });

  final VoidCallback onSignInSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        final l10n = SignInLocalizations.of(context);
        final cubit = context.read<SignInCubit>();
        if (state.error is OtpRateLimitExceededException) {
          final otpRateLimitExceededError = state.error as OtpRateLimitExceededException;
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.otpRateLimitExceededErrorSnackBarMessage(
                otpRateLimitExceededError.seconds,
              ),
            ),
          );
          return;
        }
        if (state.error is PhoneNotVerifiedException) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.phoneNotVerifiedErrorSnackBarMessage,
            ),
          );
          cubit.onUnverifiedSignIn();
          return;
        }
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          onSignInSuccess();
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
        final theme = TymerTheme.of(context);
        final l10n = SignInLocalizations.of(context);
        final colorScheme = Theme.of(context).colorScheme;
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.appBarTitle),
            backgroundColor: colorScheme.surface,
          ),
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: theme.screenMargin * 2),
              children: <Widget>[
                const SvgAsset(
                  AssetPathConstants.logoAndWordPath,
                  width: 100,
                ),
                VerticalGap.xLarge(),
                if (!state.rememberMeLoading) ...[
                  const PhoneTextField(),
                  VerticalGap.small(),
                  const PasswordTextField(),
                  VerticalGap.small(),
                ],
                const RememberMeAndForgotPassword(),
                VerticalGap.xLarge(),
                const SignInButton(),
                VerticalGap.xLarge(),
                // Text(
                //   l10n.orLoginWith,
                //   textAlign: TextAlign.center,
                // ),
                // VerticalGap.large(),
                // const SocialSignIn(),
                VerticalGap.xLarge(),
                const GoToSignUp()
              ],
            ),
          ),
        );
      },
    );
  }
}

class GoToSignUp extends StatelessWidget {
  const GoToSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = SignInLocalizations.of(context);
    final cubit = context.read<SignInCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.dontHaveAnAccount,
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: cubit.onSignUpTapped,
          child: Text(
            l10n.signUpButtonLabel,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class SocialSignIn extends StatelessWidget {
  const SocialSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: const SvgAsset(
            AssetPathConstants.googlePath,
            width: 45,
          ),
        ),
        HorizontalGap.xLarge(),
        GestureDetector(
          child: const SvgAsset(
            AssetPathConstants.facebookPath,
            width: 45,
          ),
        ),
        HorizontalGap.xLarge(),
        GestureDetector(
          child: const SvgAsset(
            AssetPathConstants.applePath,
            width: 45,
          ),
        ),
      ],
    );
  }
}
