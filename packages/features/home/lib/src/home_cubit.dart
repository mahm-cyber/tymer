import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.userRepository,
    required this.onRequestServiceTapped,
    required this.onProvideServiceTapped,
    required this.onViewDisputesTapped,
  }) : super(
          const HomeState(),
        ) {
    // userRepository.getPricingSettings(FetchPolicy.networkOnly);
  }

  final UserRepository userRepository;
  final VoidCallback onRequestServiceTapped;
  final VoidCallback onProvideServiceTapped;
  final VoidCallback onViewDisputesTapped;

// @override
// Future<void> close() async {
//
//
//   return super.close();
// }
}
