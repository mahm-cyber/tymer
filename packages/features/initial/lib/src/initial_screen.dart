import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:initial/src/initial_cubit.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';


class InitialScreen extends StatelessWidget {
  const InitialScreen({
    required this.userRepository,
    required this.onSignInTap,
    required this.onGuestSignInTap,
    required this.onSignUpTap,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onSignInTap;
  final VoidCallback onGuestSignInTap;
  final VoidCallback onSignUpTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InitialCubit>(
      create: (_) => InitialCubit(
        userRepository: userRepository,
      ),
      child: InitialView(
        onSignUpTap: onSignUpTap,
        onSignInTap: onSignInTap,
        onGuestSignInTap: onGuestSignInTap,
      ),
    );
  }
}

class InitialView extends StatelessWidget {
  const InitialView({
    required this.onSignInTap,
    required this.onGuestSignInTap,
    required this.onSignUpTap,
    super.key,
  });

  final VoidCallback onSignInTap;
  final VoidCallback onGuestSignInTap;
  final VoidCallback onSignUpTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.releaseFocus,
      child: Scaffold(
        extendBody: true,
        body: BlocBuilder<InitialCubit, InitialState>(
          builder: (context, state) {
            final textTheme = Theme.of(context).textTheme;

            final theme = TymerTheme.of(context);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                ),
                const SizedBox(
                  height: Spacing.xxxLarge,
                ),
                Text(
                  'انضم الينا اليوم',
                  style: textTheme.displaySmall?.copyWith(
                    color: theme.initialScreenTitleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: Spacing.medium,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
                  child: Text(
                    'الآن كل عياداتك و خصوماتك من مكان واحد لا يفوتك!',
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: Spacing.xxxLarge,
                ),
                SignInButton(
                  onSignInTapped: onSignInTap,
                ),
                const SizedBox(
                  height: Spacing.medium,
                ),
                SignUpButton(
                  onSignUpTapped: onSignUpTap,
                ),
                const SizedBox(
                  height: Spacing.medium,
                ),
                TextButton(
                  onPressed: onGuestSignInTap,
                  child: Text(
                    'البدء بدون حساب',
                    style: textTheme.bodyMedium?.copyWith(
                      color: theme.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
