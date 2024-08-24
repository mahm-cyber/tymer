import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:reset_password/src/components/change_password_button.dart';
import 'package:reset_password/src/components/change_password_text_form_fields/form_fields.dart';
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
    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: 'تم تغيير كلمة المرور بنجاح',
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
        final cubit = context.read<ResetPasswordCubit>();
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
                      const SizedBox(
                        height: Spacing.medium,
                      ),
                      const FormFields(),
                      const SizedBox(
                        height: Spacing.medium,
                      ),
                      const ResetPasswordButton()
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
