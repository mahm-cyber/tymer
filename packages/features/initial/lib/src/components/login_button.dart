import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:initial/src/l10n/initial_localizations.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.onSignInTapped,
  });

  final VoidCallback onSignInTapped;

  @override
  Widget build(BuildContext context) {
    final l10n = InitialLocalizations.of(context);
    final theme = TymerTheme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
      child: TymerElevatedButton(
        height: 45,
        onTap: onSignInTapped,
        label: l10n.signInButtonLabel,
      ),
    );
  }
}
