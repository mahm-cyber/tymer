import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  InitialCubit({
    required this.userRepository,
  }) : super(
          const InitialState(),
        ) {
    userRepository.getLocalePreference().distinct().listen((locale) {
      final newState = state.copyWith(locale: locale);
      if (!isClosed) emit(newState);
    });
  }

  final UserRepository userRepository;

  void switchLanguage(bool switchState) {
    // if switch is on = arabic, off = english
    final language =
        switchState ? LocalePreferenceDM.arabic : LocalePreferenceDM.english;
    final newState = state.copyWith(locale: language);
    emit(newState);
    userRepository.upsertLocalePreference(language);
  }
}
