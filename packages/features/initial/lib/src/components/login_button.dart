import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';


class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.onSignInTapped,
  });
  final VoidCallback onSignInTapped;
  @override
  Widget build(BuildContext context) {
        final theme = TymerTheme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
      child: TymerElevatedButton(
        onTap: onSignInTapped,
        label: 'تسجيل الدخول',
      ),
    );
  }
}
