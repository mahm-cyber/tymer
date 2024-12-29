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
    required this.onResetPasswordVerifyOtpSuccess,
    required this.onChangePhoneVerifyOtpSuccess,
    required this.onBackTapped,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onRegistrationVerifyOtpSuccess;
  final VoidCallback onResetPasswordVerifyOtpSuccess;
  final VoidCallback onChangePhoneVerifyOtpSuccess;
  final VoidCallback onBackTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerifyOtpCubit>(
      create: (_) => VerifyOtpCubit(
        userRepository: userRepository,
        onResetPasswordVerifyOtpSuccess: onResetPasswordVerifyOtpSuccess,
        onRegistrationVerifyOtpSuccess: onRegistrationVerifyOtpSuccess,
        onChangePhoneVerifyOtpSuccess: onChangePhoneVerifyOtpSuccess,
        onBackTapped: onBackTapped,
      ),
      child: const VerifyOtpView(),
    );
  }
}

class VerifyOtpView extends StatelessWidget {
  const VerifyOtpView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final l10n = VerifyOtpLocalizations.of(context);
    final cubit = context.read<VerifyOtpCubit>();
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Scaffold(
        bottomNavigationBar: const SizedBox(
          height: 55,
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: cubit.onBackTapped,
          ),
          backgroundColor: colorScheme.surface,
          title: Text(l10n.appBarTitle),
        ),
        extendBody: true,
        body: const _VerifyOtpForm(),
      ),
    );
  }
}

class _VerifyOtpForm extends StatelessWidget {
  const _VerifyOtpForm();

  @override
  Widget build(BuildContext context) {
    final l10n = VerifyOtpLocalizations.of(context);
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus ||
          oldState.resendOtpStatus != newState.resendOtpStatus ||
          oldState.error != newState.error,
      listener: (context, state) {
        final isForgotPassword = state.otpVerification?.reason ==
            OtpVerificationReason.forgotPassword;
        final isChangePhone =
            state.otpVerification?.reason == OtpVerificationReason.changePhone;
        final cubit = context.read<VerifyOtpCubit>();
        if (state.error is PhoneAlreadyRegisteredException) {
          Navigator.pop(context);
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.phoneAlreadyRegisteredErrorSnackBarMessage,
            ),
          );
        }
        if (state.error is OtpRateLimitExceededException) {
          final error = state.error as OtpRateLimitExceededException;
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.otpRateLimitExceededErrorSnackBarMessage(
                error.seconds,
              ),
            ),
          );
          return;
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
        // if (state.resendOtpStatus == ResendOtpStatus.error) {
        //   showSnackBar(
        //     context: context,
        //     snackBar: ErrorSnackBar(
        //       context: context,
        //       message: l10n.otpResentErrorSnackBarMessage,
        //     ),
        //   );
        // }
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: isForgotPassword
                  ? l10n.passwordResetSuccessfullySnackBarMessage
                  : isChangePhone
                      ? l10n.phoneChangedSuccessfullySnackBarMessage
                      : l10n.otpVerifiedSuccessfullySnackBarMessage,
            ),
          );
          if (isForgotPassword) {
            cubit.onResetPasswordVerifyOtpSuccess();
          } else if (isChangePhone) {
            cubit.onChangePhoneVerifyOtpSuccess();
          } else {
            cubit.onRegistrationVerifyOtpSuccess();
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
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.screenMargin,
                ),
                child: Column(
                  children: [
                    const SvgAsset(
                      AssetPathConstants.logoAndWordPath,
                      width: 70,
                    ),
                    VerticalGap.large(),
                    Text(
                      l10n.verifyOtpTitle,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
                            text: ' ${state.otpVerification?.phone}',
                            // Email text
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
                        keyboardType: TextInputType.number,
                        enableActiveFill: true,
                        autoDisposeControllers: false,
                        controller: cubit.pinTEController,
                        length: 6,
                        appContext: context,
                        cursorHeight: 20,
                        enablePinAutofill: false,
                        onChanged: cubit.onOtpCodeChanged,
                        onCompleted: (_) =>
                            isForgotPassword ? null : cubit.onSubmit(),
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
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            l10n.incompletePinErrorMessage,
                            style: textTheme.bodySmall?.copyWith(
                              color: theme.errorColor,
                            ),
                          ),
                        ),
                      if (otpCodeError == OtpCodeValidationError.incorrect)
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            l10n.incorrectOtpCodeErrorMessage,
                            style: textTheme.bodySmall?.copyWith(
                              color: theme.errorColor,
                            ),
                          ),
                        ),
                    ],
                    VerticalGap.large(),
                    if (isForgotPassword) ...[
                      const NewPassword(),
                      VerticalGap.small(),
                      const NewPasswordConfirmation(),
                    ],
                    VerticalGap.large(),
                  ],
                ),
              ),
            ),
            const ResendOtp(),
            VerticalGap.large(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
              child: isSubmissionInProgress
                  ? TymerElevatedButton.inProgress(
                      label: l10n.verifyingOtpButtonLabel)
                  : TymerElevatedButton(
                      label: l10n.verifyOtpButtonLabel,
                      onTap: cubit.onSubmit,
                    ),
            ),
            VerticalGap.large(),
          ],
        );
      },
    );
  }
}
