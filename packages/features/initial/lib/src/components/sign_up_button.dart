import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:initial/src/l10n/initial_localizations.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.onSignUpTapped,
  });

  final VoidCallback onSignUpTapped;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final l10n = InitialLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
      child: TymerElevatedButton(
        height: 45,
        bgColor: theme.materialThemeData.colorScheme.surface,
        borderColor: theme.primaryColor,
        labelColor: theme.primaryColor,
        onTap: onSignUpTapped,
        label: l10n.signUpButtonLabel,
      ),
    );
  }
}
