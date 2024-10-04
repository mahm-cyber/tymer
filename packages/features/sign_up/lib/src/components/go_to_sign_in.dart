import 'package:flutter/material.dart';
import 'package:sign_up/src/l10n/sign_up_localizations.dart';

class GoToSignIn extends StatelessWidget {
  const GoToSignIn({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = SignUpLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l10n.alreadyHaveAnAccount),
        TextButton(
          onPressed: onTap,
          child: Text(l10n.signInButtonText),
        )
      ],
    );
  }
}
