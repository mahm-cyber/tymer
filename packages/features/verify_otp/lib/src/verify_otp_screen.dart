import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:verify_otp/src/verify_otp_cubit.dart';
import 'package:user_repository/user_repository.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({
    required this.userRepository,
    required this.onVerifyOtpSuccess,
    required this.otpVerification,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onVerifyOtpSuccess;
  final OtpVerification otpVerification;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerifyOtpCubit>(
      create: (_) => VerifyOtpCubit(
        userRepository: userRepository,
        otpVerification: otpVerification,
      ),
      child: VerifyOtpView(
        onVerifyOtpSuccess: onVerifyOtpSuccess,
      ),
    );
  }
}

class VerifyOtpView extends StatelessWidget {
  const VerifyOtpView({
    required this.onVerifyOtpSuccess,
    super.key,
  });

  final VoidCallback onVerifyOtpSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Scaffold(
        extendBody: true,
        body: _VerifyOtpForm(
          onVerifyOtpSuccess: onVerifyOtpSuccess,
        ),
      ),
    );
  }
}

class _VerifyOtpForm extends StatelessWidget {
  const _VerifyOtpForm({
    required this.onVerifyOtpSuccess,
  });

  final VoidCallback onVerifyOtpSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == FormzSubmissionStatus.success) {
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: state.otpVerification?.isLoggingIn == true
                  ? 'تم تفعيل الحساب بنجاح, يمكنك الان تسجيل الدخول'
                  : state.otpVerification?.isRegistering == true
                      ? 'تم انشاء الحساب بنجاح'
                      : 'تم التغيير بنجاح',
            ),
          );
          onVerifyOtpSuccess();
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
        final otpCodeError =
            state.otpCode.isNotValid ? state.otpCode.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == FormzSubmissionStatus.inProgress;
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<VerifyOtpCubit>();
        final theme = TymerTheme.of(context);

        return Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: theme.screenMargin,
            ),
            children: [
              Text(
                'ادخل رمز التحقق',
                style: textTheme.headlineSmall,
                textAlign: TextAlign.start,
              ),
              VerticalGap.smallMedium(),
              Text(
                'ادخل رمز التحقق الذي تم ارساله الى رقم هاتفك',
                style: textTheme.bodyMedium,
              ),
              VerticalGap.large(),
              Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeTextField(
                  autoDisposeControllers: false,
                  controller: cubit.pinTEController,
                  length: 4,
                  appContext: context,
                  hintCharacter: '*',
                  cursorHeight: 20,
                  enablePinAutofill: false,
                  onChanged: cubit.onOtpCodeChanged,
                  onCompleted: (_) => cubit.onSubmit(),
                  textStyle: textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 72,
                    fieldWidth: 62,
                    borderWidth: 1,
                    activeBorderWidth: 1,
                    disabledBorderWidth: 1,
                    inactiveBorderWidth: 1,
                    errorBorderWidth: 1,
                    selectedBorderWidth: 1,
                    activeColor: otpCodeError != null ? theme.errorColor : null,
                    activeFillColor: theme.primaryColor,
                    inactiveColor: otpCodeError != null
                        ? theme.errorColor
                        : theme.borderColor,
                  ),
                ),
              ),
              if (otpCodeError != null) ...[
                const SizedBox(
                  height: Spacing.xSmall,
                ),
                if (otpCodeError == OtpCodeValidationError.empty ||
                    otpCodeError == OtpCodeValidationError.incomplete)
                  Text(
                    'مطلوب*',
                    style: textTheme.bodySmall?.copyWith(
                      color: theme.errorColor,
                    ),
                  ),
                if (otpCodeError == OtpCodeValidationError.incorrect)
                  Text(
                    'الرمز الذي ادخلته غير صحيح او غير موجود لدينا، جرب مرة اخرى',
                    style: textTheme.bodySmall?.copyWith(
                      color: theme.errorColor,
                    ),
                  ),
              ],
              const SizedBox(
                height: Spacing.huge,
              ),
              isSubmissionInProgress
                  ? TymerElevatedButton.inProgress(label: 'جارى التأكيد')
                  : TymerElevatedButton(
                      label: 'تاكيد الرمز',
                      onTap: cubit.onSubmit,
                    ),
            ],
          ),
        );
      },
    );
  }
}
