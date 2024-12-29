import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_repository/user_repository.dart';

part 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit({
    required this.userRepository,
  }) : super(
          const ChangeLanguageState(),
        ) {
    userRepository.getLocalePreference().first.then(
          (locale) => emit(
            state.copyWith(locale: locale),
          ),
        );
  }

  final UserRepository userRepository;

  Future changeLocale(LocalePreferenceDM localePreference) async {
    if (state.locale == localePreference) return;
    final loading = state.copyWith(
      localeChangeStatus: LocaleChangeStatus.loading,
    );
    emit(loading);
    try {
      await userRepository.changeLanguage(language: localePreference);
      userRepository.upsertLocalePreference(localePreference);
      final success = state.copyWith(
        localeChangeStatus: LocaleChangeStatus.success,
        locale: localePreference,
      );
      emit(success);
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(localeChangeStatus: LocaleChangeStatus.failure));
      }
    }
  }
}
