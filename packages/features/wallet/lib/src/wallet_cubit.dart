import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_repository/user_repository.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit({
    required this.userRepository,
    required this.onRequestServiceTapped,
    required this.onProvideServiceTapped,
  }) : super(
          const WalletState(),
        );

  final UserRepository userRepository;
  final VoidCallback onRequestServiceTapped;
  final VoidCallback onProvideServiceTapped;

// @override
// Future<void> close() async {
//
//
//   return super.close();
// }
}
