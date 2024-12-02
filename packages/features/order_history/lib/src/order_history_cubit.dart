import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit({
    required this.userRepository,
    required this.serviceRepository,
    required this.onCheckServiceRequestStatusTapped,
  }) : super(
          const OrderHistoryState(),
        ) {
    fetchServiceRequests();
  }

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final ValueSetter<int> onCheckServiceRequestStatusTapped;

  Future fetchServiceRequests() async {
    final loading = state.copyWith(
      serviceRequestsFetchStatus: FetchStatus.loading,
    );
    emit(
      loading,
    );

    try {
      final serviceRequests = await serviceRepository.getAllServiceRequests(
        lat: 30.0572904,
        long: 31.3728115,
        mode: 'requester',
        status: ServiceStatus.completed,
      );
      final success = state.copyWith(
        serviceRequests: serviceRequests,
        serviceRequestsFetchStatus: FetchStatus.success,
      );
      emit(success);
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            serviceRequestsFetchStatus: FetchStatus.failure,
          ),
        );
      }
    }
  }

  void onViewServiceRequestDetailsTapped(Service service) {
    final shouldCheckServiceRequestStatus =
        service.status == ServiceStatus.pending ||
            service.status == ServiceStatus.inProgress ||
            service.status == ServiceStatus.pendingReview;
    if (shouldCheckServiceRequestStatus) {
      onCheckServiceRequestStatusTapped(service.id!);
    }
    // serviceRepository.changeNotifier.setServiceRequest(service);
  }

// @override
// Future<void> close() async {
//   return super.close();
// }
}
