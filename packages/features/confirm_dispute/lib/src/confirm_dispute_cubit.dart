import 'dart:async';
import 'dart:ui';

import 'package:dispute_repository/dispute_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'confirm_dispute_state.dart';

class ConfirmDisputeCubit extends Cubit<ConfirmDisputeState> {
  ConfirmDisputeCubit({
    required this.disputeRepository,
    required this.service,
    required this.onDisputeSuccess,
  }) : super(
          const ConfirmDisputeState(),
        );

  final DisputeRepository disputeRepository;
  final Service service;
  final VoidCallback onDisputeSuccess;

  Future disputeService() async {
    final loading = state.copyWith(
      disputingStatus: DisputingStatus.loading,
    );
    emit(loading);
    try {
      await disputeRepository.disputeRequest(
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
