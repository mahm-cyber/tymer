import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verify_otp/src/l10n/verify_otp_localizations.dart';

import 'package:verify_otp/src/verify_otp_cubit.dart';

class ResendOtp extends StatelessWidget {
  const ResendOtp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
      builder: (context, state) {
        final isResendOtpInProgress =
            state.resendOtpStatus == ResendOtpStatus.inProgress;
        final cubit = context.read<VerifyOtpCubit>();
        final l10n = VerifyOtpLocalizations.of(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: isResendOtpInProgress || state.resendOtpTotalTime > 0
                  ? null
                  : cubit.resendOtp,
              icon: isResendOtpInProgress
                  ? Transform.scale(
                      scale: 0.5,
                      child: const CircularProgressIndicator(),
                    )
                  : const Icon(Icons.refresh),
              label: Text(l10n.resendOtpButtonLabel),
            ),
            HorizontalGap.medium(),
            Text(
              '${(state.resendOtpTotalTime / 60).toInt().floor()}:${(state.resendOtpSecondTimer) < 10 ? state.resendOtpSecondTimer.toStringAsFixed(0).padLeft(2, '0') : state.resendOtpSecondTimer.toStringAsFixed(0)}',
            ),
          ],
        );
      },
    );
  }
}
