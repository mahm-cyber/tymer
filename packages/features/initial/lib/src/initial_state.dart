part of 'initial_cubit.dart';

class InitialState extends Equatable {
  const InitialState({
    this.locale,
  });

  final LocalePreferenceDM? locale;

  InitialState copyWith({
    LocalePreferenceDM? locale,
  }) {
    return InitialState(
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
        locale,
      ];
}
