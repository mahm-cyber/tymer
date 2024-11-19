import 'dart:async';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

part 'service_request_status_state.dart';

class ServiceRequestStatusCubit extends Cubit<ServiceRequestStatusState> {
  ServiceRequestStatusCubit({
    required this.userRepository,
    required this.serviceRepository,
    required this.requestId,
  }) : super(
    const ServiceRequestStatusState(),
  ) {
    //poll service using a timer everysecond
    Timer.periodic(
      const Duration(seconds: 1),
          (timer) async {
        if (state.service?.status == ServiceStatus.completed) {
          timer.cancel();
        }
        await getService();
      },
    );
  }

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final int requestId;

  Future<Service> getService() async {
    final loading = state.copyWith(fetchStatus: FetchStatus.loading);
    emit(loading);
    try {
      final service = await serviceRepository.getServiceRequest(
        requestId: requestId,
      );
      final loaded = state.copyWith(
        fetchStatus: FetchStatus.loaded,
        service: service,
      );
      emit(loaded);
      return service;
    } catch (error) {
      final errorState = state.copyWith(fetchStatus: FetchStatus.error);
      emit(errorState);
      rethrow;
    }
  }
}
