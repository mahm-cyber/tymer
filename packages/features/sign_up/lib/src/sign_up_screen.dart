import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

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

  final VoidCallback onSignInTap;
  final VoidCallback onSignUpSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: 'تم انشاء الحساب بنجاح',
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
              message: 'حدث خطأ ما',
            ),
          );
          return;
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();
        final theme = TymerTheme.of(context);

        return GestureDetector(
          onTap: () {
            context.releaseFocus();
            if (state.passwordInfoOverlayShown) {
              cubit.togglePasswordInfoOverlay(
                state.passwordInfoOverlayYOffset,
              );
            }
          },
          child: Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: theme.screenMargin,
                    left: theme.screenMargin,
                    top:
                        MediaQuery.of(context).padding.top + theme.screenMargin,
                    bottom: theme.screenMargin,
                  ),
                  child: Column(
                    children: [
                      const Header(),
                      const SizedBox(
                        height: Spacing.medium,
                      ),
                      const FormFields(),
                      const SignUpButton(),
                      if (state.scrollDirection == ScrollDirection.forward) ...[
                        const SizedBox(
                          height: Spacing.medium,
                        ),
                        const SocialSignUp(),
                        GoToSignIn(onTap: onSignInTap),
                      ],
                    ],
                  ),
                ),
                PasswordFormatTooltip(
                  passwordInfoOverlayYOffset: state.passwordInfoOverlayYOffset,
                  passwordInfoOverlayShown: state.passwordInfoOverlayShown,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
