import 'dart:ui';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_repository/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.userRepository,
    required this.onRequestServiceTapped,
    required this.onProvideServiceTapped,
    required this.onLogout,
  }) : super(
          const ProfileState(),
        ) {
    userRepository.getUser().first.then(
          (user) => emit(
            state.copyWith(user: user),
          ),
        );
  }

  final UserRepository userRepository;
  final VoidCallback onRequestServiceTapped;
  final VoidCallback onProvideServiceTapped;
  final VoidCallback onLogout;

  void logout() async {
    try {
      final logoutInProgress =
          state.copyWith(logoutStatus: LogoutStatus.loading);
      emit(logoutInProgress);

      await userRepository.logout();
      emit(state.copyWith(logoutStatus: LogoutStatus.success));
      onLogout();
    } catch (e) {
      emit(state.copyWith(logoutStatus: LogoutStatus.failure));
    }
  }

  void changeLocale(LocalePreferenceDM localePreference) {
    userRepository.upsertLocalePreference(localePreference);
  }
// @override
// Future<void> close() async {
//
//
//   return super.close();
// }
}
