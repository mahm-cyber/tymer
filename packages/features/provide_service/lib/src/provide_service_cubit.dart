import 'dart:async';
import 'dart:ui';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

part 'provide_service_state.dart';

class ProvideServiceCubit extends Cubit<ProvideServiceState> {
  ProvideServiceCubit({
    required this.userRepository,
    required this.serviceRepository,
    required this.onServiceRequestDetailsTapped,
  }) : super(
          const ProvideServiceState(),
        ) {
    init();
  }

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback onServiceRequestDetailsTapped;
  Timer? timer;

  void init() async {
    emit(state.copyWith(serviceRequestsFetchStatus: FetchStatus.loading));
    bool isApiCallInProgress = true;
    fetchServiceRequests();
    isApiCallInProgress = false;
    // poll fetch service requests to update the list every 2500 milliseconds
    timer = Timer.periodic(const Duration(milliseconds: 2500), (timer) async {
      if (!isApiCallInProgress) {
        isApiCallInProgress = true;
        fetchServiceRequests();
        isApiCallInProgress = false;
      }
    });
  }

  void fetchServiceRequests() async {
    final locationData = await serviceRepository.getUserLocation();
    if (locationData == null) return;

    try {
      final serviceRequests = await serviceRepository.getAllServiceRequests(
        lat: locationData.latitude!,
        long: locationData.longitude!,
        mode: 'provider',
        status: ServiceStatus.pending,
      );
      emit(
        state.copyWith(
          serviceRequests: serviceRequests,
          serviceRequestsFetchStatus: FetchStatus.success,
        ),
      );
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
    onServiceRequestDetailsTapped();
    serviceRepository.changeNotifier.setServiceRequest(service);
  }

  @override
  Future<void> close() async {
    timer?.cancel();
    return super.close();
  }
}
