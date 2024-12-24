import 'package:change_password/src/components/change_password_text_form_fields/form_fields.dart';
import 'package:change_password/src/l10n/change_password_localizations.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:change_password/src/change_password_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';


class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({
    required this.userRepository,
    required this.onChangePasswordSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onChangePasswordSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (_) => ChangePasswordCubit(
        userRepository: userRepository,
      ),
      child: ChangePasswordView(
        onChangePasswordSuccess: onChangePasswordSuccess,
      ),
    );
  }
}

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({
    super.key,
    required this.onChangePasswordSuccess,
  });

  final VoidCallback onChangePasswordSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus ,
      listener: (context, state) {
        final l10n = ChangePasswordLocalizations.of(context);

        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.changePasswordSuccessMessage,
            ),
          );
          onChangePasswordSuccess();
          return;
        }
        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.changePasswordFailureMessage,
            ),
          );
          return;
        }
      },
      builder: (context, state) {
        final l10n = ChangePasswordLocalizations.of(context);
        final colorScheme = Theme.of(context).colorScheme;

        return GestureDetector(
          onTap: () {
            context.releaseFocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.appBarTitle),
              backgroundColor: colorScheme.surface,
            ),
            body: const Center(child: FormFields()),
          ),
        );
      },
    );
  }
}
