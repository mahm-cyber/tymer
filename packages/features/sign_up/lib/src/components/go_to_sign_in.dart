import 'package:flutter/material.dart';

class GoToSignIn extends StatelessWidget {
  const GoToSignIn({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(' لديك حساب؟ قم'),
        TextButton(
          onPressed: onTap,
          child: const Text('بتسجيل الدخول'),
        )
      ],
    );
  }
}
