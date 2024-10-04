import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
import 'package:initial/src/initial_cubit.dart';
import 'package:user_repository/user_repository.dart';

import 'components/components.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({
    required this.userRepository,
    required this.onSignInTap,
    required this.onSignUpTap,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onSignInTap;
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
      ),
    );
  }
}

class InitialView extends StatelessWidget {
  const InitialView({
    required this.onSignInTap,
    required this.onSignUpTap,
    super.key,
  });

  final VoidCallback onSignInTap;
  final VoidCallback onSignUpTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = TymerTheme.of(context).materialThemeData.colorScheme;
    final cubit = context.read<InitialCubit>();

    final textTheme = Theme.of(context).textTheme;
    final theme = TymerTheme.of(context);
    return BlocBuilder<InitialCubit, InitialState>(builder: (context, state) {
      return GestureDetector(
        onTap: context.releaseFocus,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorScheme.surface,
            title: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'English',
                    style: textTheme.bodyMedium?.copyWith(
                      color: state.locale == LocalePreferenceDM.english
                          ? colorScheme.primary
                          : theme.dimmedTextColor,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  HorizontalGap.medium(),
                  Switch.adaptive(
                    value: state.locale == LocalePreferenceDM.arabic,
                    onChanged: cubit.switchLanguage,
                  ),
                  HorizontalGap.medium(),
                  Text(
                    'عربى',
                    style: textTheme.bodyMedium?.copyWith(
                      color: state.locale == LocalePreferenceDM.arabic
                          ? colorScheme.primary
                          : theme.dimmedTextColor,
                      fontFamily: 'Tajawal',
                    ),
                  ),
                ],
              ),
            ),
          ),
          extendBody: true,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgAsset(
                AssetPathConstants.logoAndWordPath,
              ),
              VerticalGap.xxLarge(),
              SignInButton(
                onSignInTapped: onSignInTap,
              ),
              const SizedBox(
                height: Spacing.medium,
              ),
              SignUpButton(
                onSignUpTapped: onSignUpTap,
              ),
            ],
          ),
        ),
      );
    });
  }
}
