import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_repository/user_repository.dart';

part 'request_service_state.dart';

class RequestServiceCubit extends Cubit<RequestServiceState> {
  RequestServiceCubit({
    required this.userRepository,
    required this.onLogout,
  }) : super(
          const RequestServiceState(),
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
