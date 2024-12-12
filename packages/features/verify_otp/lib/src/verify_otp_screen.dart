import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:verify_otp/src/l10n/verify_otp_localizations.dart';

import 'package:verify_otp/src/verify_otp_cubit.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({
    required this.userRepository,
    required this.onRegistrationVerifyOtpSuccess,
    required this.onResetPasswordSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onRegistrationVerifyOtpSuccess;
  final VoidCallback onResetPasswordSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerifyOtpCubit>(
      create: (_) => VerifyOtpCubit(
        userRepository: userRepository,
        onResetPasswordSuccess: onResetPasswordSuccess,
      ),
      child: VerifyOtpView(
        onRegistrationVerifyOtpSuccess: onRegistrationVerifyOtpSuccess,
      ),
    );
  }
}

class VerifyOtpView extends StatelessWidget {
  const VerifyOtpView({
    required this.onRegistrationVerifyOtpSuccess,
    super.key,
  });

  final VoidCallback onRegistrationVerifyOtpSuccess;

  @override
  Widget build(BuildContext context) {
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Scaffold(
        bottomNavigationBar: const SizedBox(
          height: 55,
        ),
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          title: Text(
            VerifyOtpLocalizations.of(context).verifyOtpTitle,
          ),
        ),
        extendBody: true,
        body: _VerifyOtpForm(
          onRegistrationVerifyOtpSuccess: onRegistrationVerifyOtpSuccess,
        ),
      ),
    );
  }
}

class _VerifyOtpForm extends StatelessWidget {
  const _VerifyOtpForm({
    required this.onRegistrationVerifyOtpSuccess,
  });

  final VoidCallback onRegistrationVerifyOtpSuccess;

  @override
  Widget build(BuildContext context) {
    final l10n = VerifyOtpLocalizations.of(context);
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus ||
          oldState.resendOtpStatus != newState.resendOtpStatus,
      listener: (context, state) {
        final isForgotPassword = state.otpVerification?.reason ==
            OtpVerificationReason.forgotPassword;
        final cubit = context.read<VerifyOtpCubit>();
        if (state.otpCode.limitExceeded != null) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.otpLimitExceededErrorSnackBarMessage(state.otpCode.limitExceeded!.seconds),
            ),
          );
        }
        if (state.resendOtpStatus == ResendOtpStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.otpResentSuccessfullySnackBarMessage,
            ),
          );
        }
        if (state.resendOtpStatus == ResendOtpStatus.error) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.otpResentErrorSnackBarMessage,
            ),
          );
        }
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: isForgotPassword
                  ? l10n.passwordResetSuccessfullySnackBarMessage
                  : l10n.otpVerifiedSuccessfullySnackBarMessage,
            ),
          );
          if (isForgotPassword) {
            cubit.onResetPasswordSuccess();
          } else {
            onRegistrationVerifyOtpSuccess();
          }
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
        final otpCodeError =
            state.otpCode.isNotValid ? state.otpCode.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;

        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<VerifyOtpCubit>();
        final theme = TymerTheme.of(context);
        final colorScheme =
            TymerTheme.of(context).materialThemeData.colorScheme;
        final isForgotPassword = state.otpVerification?.reason ==
            OtpVerificationReason.forgotPassword;
        return Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: theme.screenMargin,
            ),
            child: Column(
              // shrinkWrap: true,
              children: [
                const SvgAsset(
                  AssetPathConstants.logoAndWordPath,
                  width: 70,
                ),
                VerticalGap.large(),
                Text(
                  l10n.verifyOtpTitle,
                  style: textTheme.headlineSmall,
                  textAlign: TextAlign.start,
                ),
                VerticalGap.smallMedium(),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: l10n.verifyOtpSubtitle,
                        style: textTheme
                            .bodyMedium, // Default style for the subtitle
                      ),
                      TextSpan(
                        text: ' ${state.otpVerification?.phone}', // Email text
                        style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold), // Make email bold
                      ),
                    ],
                  ),
                ),
                VerticalGap.large(),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeTextField(
                    enableActiveFill: true,
                    autoDisposeControllers: false,
                    controller: cubit.pinTEController,
                    length: 6,
                    appContext: context,
                    cursorHeight: 20,
                    enablePinAutofill: false,
                    onChanged: cubit.onOtpCodeChanged,
                    onCompleted: (_) => cubit.onSubmit(),
                    cursorColor: colorScheme.surface,
                    textStyle: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.surface),
                    pinTheme: PinTheme(
                      selectedColor: Colors.transparent,
                      selectedFillColor:
                          otpCodeError == OtpCodeValidationError.incorrect
                              ? theme.errorColor
                              : theme.primaryColor,
                      inactiveFillColor: theme.borderColor,
                      shape: PinCodeFieldShape.box,
                      fieldHeight: 45,
                      fieldWidth: 45,
                      borderWidth: 1,
                      borderRadius: BorderRadius.circular(10),
                      activeBorderWidth: 1,
                      disabledBorderWidth: 1,
                      inactiveBorderWidth: 1,
                      errorBorderWidth: 1,
                      selectedBorderWidth: 1,
                      activeColor:
                          otpCodeError == OtpCodeValidationError.incorrect
                              ? theme.errorColor
                              : null,
                      activeFillColor:
                          otpCodeError == OtpCodeValidationError.incorrect
                              ? theme.errorColor
                              : theme.primaryColor,
                      inactiveColor:
                          otpCodeError == OtpCodeValidationError.incorrect
                              ? theme.errorColor
                              : theme.borderColor,
                    ),
                    separatorBuilder: (context, index) =>
                        HorizontalGap.smallMedium(),
                  ),
                ),
                if (otpCodeError != null) ...[
                  const SizedBox(
                    height: Spacing.xSmall,
                  ),
                  if (otpCodeError == OtpCodeValidationError.empty ||
                      otpCodeError == OtpCodeValidationError.incomplete)
                    Text(
                      l10n.requiredFieldErrorMessage,
                      style: textTheme.bodySmall?.copyWith(
                        color: theme.errorColor,
                      ),
                    ),
                  if (otpCodeError == OtpCodeValidationError.incorrect)
                    Text(
                      l10n.incorrectOtpCodeErrorMessage,
                      style: textTheme.bodySmall?.copyWith(
                        color: theme.errorColor,
                      ),
                    ),
                ],
                VerticalGap.large(),
                if (isForgotPassword) ...[
                const NewPassword(),
                VerticalGap.xSmall(),
                const NewPasswordConfirmation(),
                ],
                VerticalGap.large(),
                const ResendOtp(),
                VerticalGap.large(),
                isSubmissionInProgress
                    ? TymerElevatedButton.inProgress(
                        label: l10n.verifyingOtpButtonLabel)
                    : TymerElevatedButton(
                        label: l10n.verifyOtpButtonLabel,
                        onTap: cubit.onSubmit,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
