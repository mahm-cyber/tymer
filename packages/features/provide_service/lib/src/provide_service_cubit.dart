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
    required this.navigateToFulfillServiceRequest,
  }) : super(
          const ProvideServiceState(),
        ) {
    init();
  }

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback onServiceRequestDetailsTapped;
  final VoidCallback navigateToFulfillServiceRequest;
  Timer? _timer;

  void init() async {
    emit(state.copyWith(serviceRequestsFetchStatus: FetchStatus.loading));

    final service = await checkIfUserHasRunningServiceRequest();
    if (service != null) {
      serviceRepository.changeNotifier.setServiceRequest(service);
      //TODO: navigate to fulfill service request screen
      //TODO: show snack bar to notify the user that he has a running service request
      final runningServiceRequestState = state.copyWith(
        runningServiceRequest: service,
      );
      emit(runningServiceRequestState);
      navigateToFulfillServiceRequest();
      return;
    }
    bool isApiCallInProgress = true;
    await fetchServiceRequests();
    isApiCallInProgress = false;
    // poll fetch service requests to update the list every 2500 milliseconds
    _timer = Timer.periodic(
      const Duration(milliseconds: 2500),
      (timer) async {
        if (!isApiCallInProgress) {
          isApiCallInProgress = true;
          fetchServiceRequests();
          isApiCallInProgress = false;
        }
      },
    );
  }

  Future fetchServiceRequests() async {
    final locationData = await serviceRepository.getUserLocation();
    if (locationData == null) return;

    try {
      final serviceRequests = await serviceRepository.getAllServiceRequests(
        lat: locationData.latitude!,
        long: locationData.longitude!,
        mode: 'provider',
        status: ServiceStatus.pending,
      );
      final successState = state.copyWith(
        serviceRequests: serviceRequests.list,
        serviceRequestsFetchStatus: FetchStatus.success,
      );
      emit(successState);
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

  Future<Service?> checkIfUserHasRunningServiceRequest() async {
    try {
      final serviceRequestsInProgress =
          await serviceRepository.getAllServiceRequests(
        lat: 30.0444,
        long: 31.2357,
        mode: 'provider',
        status: ServiceStatus.inProgress,
      );
      final serviceRequestsPendingReview =
          await serviceRepository.getAllServiceRequests(
        lat: 30.0444,
        long: 31.2357,
        mode: 'provider',
        status: ServiceStatus.pendingReview,
      );
      final hasRunningServiceRequest =
          serviceRequestsInProgress.list.isNotEmpty;
      final hasPendingReviewServiceRequest =
          serviceRequestsPendingReview.list.isNotEmpty;
      if (hasRunningServiceRequest) {
        return serviceRequestsInProgress.list.first;
      } else if (hasPendingReviewServiceRequest) {
        return serviceRequestsPendingReview.list.first;
      } else {
        return null;
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            serviceRequestsFetchStatus: FetchStatus.failure,
          ),
        );
      }
      rethrow;
    }
  }

  void onViewServiceRequestDetailsTapped(Service service) {
    onServiceRequestDetailsTapped();
    serviceRepository.changeNotifier.setServiceRequest(service);
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    return super.close();
  }
}
