import 'dart:async';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_repository/service_repository.dart';


part 'confirm_dispute_state.dart';

class ConfirmDisputeCubit extends Cubit<ConfirmDisputeState> {
  ConfirmDisputeCubit({
    required this.serviceRepository,
    required this.service,
  }) : super(
          const ConfirmDisputeState(),
        );

  final ServiceRepository serviceRepository;
  final Service service;

  Future disputeService() async {
    final loading = state.copyWith(
      disputingStatus: DisputingStatus.loading,
    );
    emit(loading);
    try {
      await serviceRepository.disputeRequest(
        serviceRequestId: service.id!,
        reason: state.reason!,
      );
      final loaded = state.copyWith(
        disputingStatus: DisputingStatus.success,
      );
      emit(loaded);
    } catch (error) {
      final errorState = state.copyWith(disputingStatus: DisputingStatus.error);
      emit(errorState);
      rethrow;
    }
  }

  void updateDisputeMessage(String value) {
    final newState = state.copyWith(reason: value);
    emit(newState);
  }
}
