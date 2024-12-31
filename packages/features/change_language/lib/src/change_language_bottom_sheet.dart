import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:change_language/src/change_language_cubit.dart';

import 'package:user_repository/user_repository.dart';

class ChangeLanguageBottomSheet extends StatelessWidget {
  const ChangeLanguageBottomSheet({
    required this.userRepository,
    required this.onBackButtonPressed,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangeLanguageCubit>(
      create: (_) => ChangeLanguageCubit(
        userRepository: userRepository,
        onBackButtonPressed: onBackButtonPressed,
      ),
      child: const ChangeLanguageView(),
    );
  }
}

class ChangeLanguageView extends StatelessWidget {
  const ChangeLanguageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TymerTheme.of(context);
    final cubit = context.read<ChangeLanguageCubit>();
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context);
    return BlocConsumer<ChangeLanguageCubit, ChangeLanguageState>(
      listenWhen: (previous, current) =>
          previous.localeChangeStatus != current.localeChangeStatus,
      listener: (context, state) {
        if (state.localeChangeStatus == LocaleChangeStatus.success) {
          Navigator.of(context).pop();
        }
        if (state.localeChangeStatus == LocaleChangeStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(context: context),
          );
        }
      },
      builder: (context, state) {
        final changeLangInProgress =
            state.localeChangeStatus == LocaleChangeStatus.loading;
        final colorScheme = theme.materialThemeData.colorScheme;
        return BackButtonListener(
          onBackButtonPressed: () async {
            cubit.onBackButtonPressed();
            return true;
          },
          child: Container(
            color: theme.primaryColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  tileColor: theme.primaryColor,
                  titleTextStyle: textTheme.titleMedium?.copyWith(
                    color: theme.materialThemeData.colorScheme.surface,
                  ),
                  iconColor: theme.materialThemeData.colorScheme.surface,
                  title: const Text('عربى'),
                  onTap: changeLangInProgress
                      ? null
                      : () => cubit.changeLocale(LocalePreferenceDM.arabic),
                  trailing: locale == const Locale('ar', '')
                      ? const Icon(Icons.radio_button_checked_sharp)
                      : state.locale == LocalePreferenceDM.english &&
                              changeLangInProgress
                          ? Transform.scale(
                              scale: 0.65,
                              child: CircularProgressIndicator(
                                color: colorScheme.surface,
                              ),
                            )
                          : const Icon(Icons.radio_button_unchecked_sharp),
                ),
                ListTile(
                  tileColor: theme.primaryColor,
                  title: const Text('English'),
                  titleTextStyle: textTheme.titleMedium?.copyWith(
                    color: theme.materialThemeData.colorScheme.surface,
                  ),
                  iconColor: theme.materialThemeData.colorScheme.surface,
                  onTap: changeLangInProgress
                      ? null
                      : () => cubit.changeLocale(LocalePreferenceDM.english),
                  trailing: locale == const Locale('en', '')
                      ? const Icon(Icons.radio_button_checked_sharp)
                      : state.locale == LocalePreferenceDM.arabic &&
                              changeLangInProgress
                          ? Transform.scale(
                              scale: 0.65,
                              child: CircularProgressIndicator(
                                color: colorScheme.surface,
                              ),
                            )
                          : const Icon(Icons.radio_button_unchecked_sharp),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
