part of 'change_language_cubit.dart';

class ChangeLanguageState extends Equatable {
  const ChangeLanguageState({
    this.localeChangeStatus = LocaleChangeStatus.initial,
    this.locale,
  });

  final LocaleChangeStatus localeChangeStatus;
  final LocalePreferenceDM? locale;
  ChangeLanguageState copyWith({
    LocaleChangeStatus? localeChangeStatus,
    LocalePreferenceDM? locale,
  }) {
    return ChangeLanguageState(
      localeChangeStatus: localeChangeStatus ?? this.localeChangeStatus,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
        localeChangeStatus,
        locale,
      ];
}

enum LocaleChangeStatus {
  initial,
  loading,
  success,
  failure,
}
