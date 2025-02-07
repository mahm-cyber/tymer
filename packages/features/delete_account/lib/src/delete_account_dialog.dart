import 'package:component_library/component_library.dart';
import 'package:delete_account/delete_account.dart';
import 'package:delete_account/src/components/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delete_account/src/delete_account_cubit.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({
    required this.userRepository,
    required this.onAccountDeletedSuccessfully,
    required this.onBackButtonPressed,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onAccountDeletedSuccessfully;
  final VoidCallback onBackButtonPressed;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteAccountCubit>(
      create: (_) => DeleteAccountCubit(
        userRepository: userRepository,
        onAccountDeletedSuccessfully: onAccountDeletedSuccessfully,
        onBackButtonPressed: onBackButtonPressed,
      ),
      child: const DeleteAccountView(),
    );
  }
}

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final cubit = context.read<DeleteAccountCubit>();
    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        final l10n = DeleteAccountLocalizations.of(context);
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          cubit.onAccountDeletedSuccessfully();
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.deleteAccountSuccessMessage,
              marginalSpace: theme.snackBarMargin,
            ),
          );
        } else if (state.submissionStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              marginalSpace: theme.snackBarMargin,
            ),
          );
        }
      },
      builder: (context, state) {
        final deleteAccountInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final colorScheme = theme.materialThemeData.colorScheme;
        final l10n = DeleteAccountLocalizations.of(context);
        final textTheme = Theme.of(context).textTheme;
        return BackButtonListener(
          onBackButtonPressed: () async {
            cubit.onBackButtonPressed();
            return true;
          },
          child: AlertDialog(
            title: Text(
              l10n.deleteAccountTitle,
              style: textTheme.titleLarge,
            ),
            content: Text(
              l10n.deleteAccountContent,
              style: textTheme.bodyMedium,
            ),
            
            actions: [
              const PasswordTextField(),
              VerticalGap.medium(),
              deleteAccountInProgress
                  ? TymerElevatedButton.inProgress(
                      label: l10n.deleteAccountButton,
                    )
                  : TymerElevatedButton(
                      onTap: cubit.onSubmit,
                      label: (l10n.deleteAccountButton),
                      bgColor: colorScheme.error,
                    ),
              VerticalGap.medium(),
              TymerElevatedButton(
                bgColor: colorScheme.surface,
                borderColor: theme.borderColor,
                labelColor: colorScheme.onSurface,
                onTap: cubit.onBackButtonPressed,
                label: (l10n.cancelButtonLabel),
              ),
            ],
          ),
        );
      },
    );
  }
}
