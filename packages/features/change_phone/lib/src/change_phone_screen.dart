import 'package:change_phone/src/components/components.dart';
import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:change_phone/change_phone.dart';
import 'package:change_phone/src/components/lib/phone_text_field.dart';
import 'package:change_phone/src/change_phone_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';

class ChangePhoneScreen extends StatelessWidget {
  const ChangePhoneScreen({
    super.key,
    required this.userRepository,
    required this.onOtpSentSuccess,
  });

  final UserRepository userRepository;
  final VoidCallback onOtpSentSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePhoneCubit>(
      create: (_) => ChangePhoneCubit(
        userRepository: userRepository,
      ),
      child: ChangePhoneView(
        onOtpSentSuccess: onOtpSentSuccess,
      ),
    );
  }
}

class ChangePhoneView extends StatelessWidget {
  const ChangePhoneView({
    required this.onOtpSentSuccess,
    super.key,
  });

  final VoidCallback onOtpSentSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.releaseFocus(),
      child: _ChangePhoneForm(
        onOtpSentSuccess: onOtpSentSuccess,
      ),
    );
  }
}

class _ChangePhoneForm extends StatelessWidget {
  const _ChangePhoneForm({
    required this.onOtpSentSuccess,
  });

  final VoidCallback onOtpSentSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePhoneCubit, ChangePhoneState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        final l10n = ChangePhoneLocalizations.of(context);

        if (state.error is OtpRateLimitExceededException) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.otpRateLimitExceededExceptionErrorSnackBarMessage,
            ),
          );
          return;
        }
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          onOtpSentSuccess();
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.otpSentSnackBarMessage,
            ),
          );
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
        final l10n = ChangePhoneLocalizations.of(context);
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
                const PhoneTextField(),
                VerticalGap.small(),
                const PasswordTextField(),
                VerticalGap.small(),
                VerticalGap.xLarge(),
                const ChangePhoneButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
