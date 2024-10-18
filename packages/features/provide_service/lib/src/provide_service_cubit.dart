import 'dart:async';

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
  }) : super(
          const ProvideServiceState(),
        ) {
    init();
  }

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
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

  Future<LocationData?> getUserLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    final locationData = await location.getLocation();
    return locationData;
  }

  void fetchServiceRequests() async {
    final locationData = await getUserLocation();
    if (locationData == null) return;

    try {
      final serviceRequests = await serviceRepository.getAllServiceRequests(
        lat: locationData.latitude!,
        long: locationData.longitude!,
        mode: 'provider',
      );
      emit(
        state.copyWith(
          serviceRequests: serviceRequests,
          serviceRequestsFetchStatus: FetchStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          serviceRequestsFetchStatus: FetchStatus.failure,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    timer?.cancel();
    return super.close();
  }
}
