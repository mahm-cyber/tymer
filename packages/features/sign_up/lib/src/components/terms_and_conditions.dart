import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sign_up/src/l10n/sign_up_localizations.dart';
import 'package:sign_up/src/sign_up_cubit.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = SignUpLocalizations.of(context);
    final cubit = context.read<SignUpCubit>();
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      final error = state.termsAndConditionsAccepted.isNotValid
          ? state.termsAndConditionsAccepted.error
          : null;
      return Row(
        children: [
          TextButton(
            onPressed: cubit.getAndShowTermsAndConditions,
            child: Text(
              l10n.agreeAndAcceptAllButtonText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    decoration: TextDecoration.underline,
                    color: error != null ? theme.errorColor : null,
                  ),
            ),
          ),
          const Spacer(),
          Transform.scale(
            scale: 0.8,
            child: Switch.adaptive(
              inactiveTrackColor: error != null
                  ? theme.errorColor
                  : state.termsAndConditionsAccepted.value == true
                      ? theme.switchInactiveTrackColor
                      : theme.switchInactiveTrackColor,
              inactiveThumbColor: theme.materialThemeData.colorScheme.surface,
              trackOutlineColor: WidgetStateProperty.resolveWith(
                (final Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return null;
                  }
                  return const Color(0xFFDCE0E1);
                },
              ),
              value: state.termsAndConditionsAccepted.value == true,
              onChanged: cubit.onTermsAndConditionsChanged,
            ),
          ),
        ],
      );
    });
  }
}
