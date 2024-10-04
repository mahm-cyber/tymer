import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.userRepository,
    required this.onLogout,
  }) : super(
          const HomeState(),
        );

  final UserRepository userRepository;
  final VoidCallback onLogout;

// @override
// Future<void> close() async {
//
//
//   return super.close();
// }
}
