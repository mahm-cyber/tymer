import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_in/sign_in.dart';
import 'package:sign_in/src/sign_in_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

import 'components/components.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    required this.userRepository,
    required this.onSignInSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onSignInSuccess;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (_) => SignInCubit(
        userRepository: widget.userRepository,
      ),
      child: SignInView(
        onSignInSuccess: widget.onSignInSuccess,
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
        if (state.error is UserExpiredException) {
          showSnackBar(
            context: context,
            snackBar: const UserExpiredSnackBar(),
          );
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

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                VerticalGap.large(),
                VerticalGap.large(),
                if (!state.rememberMeLoading) ...[
                  const EmailTextField(),
                  VerticalGap.mediumLarge(),
                  const PasswordTextField(),
                  VerticalGap.medium(),
                ],
                const RememberMeAndForgotPassword(),
                VerticalGap.xLarge(),
                const SignInButton(),
                VerticalGap.large(),
              ],
            ),
          ),
        );
      },
    );
  }
}

