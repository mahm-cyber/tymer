import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';


class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.onSignUpTapped,
  });

  final VoidCallback onSignUpTapped;

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
      child: TymerElevatedButton(
        bgColor: theme.materialThemeData.colorScheme.surface,
        borderColor: theme.primaryColor,
        labelColor: theme.primaryColor,
        onTap: onSignUpTapped,
        label: 'اشتراك',
      ),
    );
  }
}
