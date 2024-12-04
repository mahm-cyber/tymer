import 'dart:async';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

part 'service_request_status_state.dart';

class ServiceRequestStatusCubit extends Cubit<ServiceRequestStatusState> {
  ServiceRequestStatusCubit({
    required this.userRepository,
    required this.serviceRepository,
    required this.goBackHome,
    required this.requestId,
  }) : super(
          const ServiceRequestStatusState(),
        ) {
    //poll service using a timer everysecond
    userRepository.getUserToken().then((token) {
      emit(state.copyWith(userToken: token));
    });
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        if (state.service?.status == ServiceStatus.completed ||
            state.service?.status == ServiceStatus.pendingReview) {
          timer.cancel();
        }
        await getService();
      },
    );
  }

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback goBackHome;
  final int requestId;
  Timer? _timer;

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

  Future confirmService() async {
    final loading = state.copyWith(
      confirmationStatus: ConfirmationStatus.loading,
    );
    emit(loading);
    try {
      await serviceRepository.confirmServiceRequest(
        serviceRequestId: requestId,
      );
      final loaded = state.copyWith(
        confirmationStatus: ConfirmationStatus.success,
      );
      emit(loaded);
    } catch (error) {
      final errorState =
          state.copyWith(confirmationStatus: ConfirmationStatus.error);
      emit(errorState);
      rethrow;
    }
  }

  Future cancelService() async {
    final loading = state.copyWith(
      cancellationStatus: CancellationStatus.loading,
    );
    emit(loading);
    try {
      await serviceRepository.cancelServiceRequest(
        serviceRequestId: requestId,
      );
      final loaded = state.copyWith(
        cancellationStatus: CancellationStatus.success,
      );
      emit(loaded);
    } catch (error) {
      final errorState =
          state.copyWith(cancellationStatus: CancellationStatus.error);
      emit(errorState);
      rethrow;
    }
  }

  void onViewServiceOnMap() async {
    try {
      final coordinates = state.service!.location.coordinates;
      serviceRepository.launchMap(
        coordinates[0],
        coordinates[1],
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    return super.close();
  }
}
