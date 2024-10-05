import 'dart:ui';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

part 'choose_service_state.dart';

class ChooseServiceCubit extends Cubit<ChooseServiceState> {
  ChooseServiceCubit({
    required this.userRepository,
    required this.serviceRepository,
    required this.onRequestServiceTapped,
  }) : super(
          const ChooseServiceState(),
        );

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback onRequestServiceTapped;

  void setServiceType(ServiceType serviceType) {
    serviceRepository.changeNotifier.setServiceType(serviceType);
    onRequestServiceTapped();
  }

// @override
// Future<void> close() async {
//
//
//   return super.close();
// }
}
