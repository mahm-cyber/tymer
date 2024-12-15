import 'dart:async';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

part 'request_service_state.dart';

class RequestServiceCubit extends Cubit<RequestServiceState> {
  RequestServiceCubit({
    required this.userRepository,
    required this.serviceRepository,
    required this.onGoToWalletTapped,
    required this.onServiceRequestSuccess,
  }) : super(
          RequestServiceState(
            serviceType: serviceRepository.changeNotifier.serviceType,
          ),
        ) {
    init();
  }

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final VoidCallback onGoToWalletTapped;
  final ValueSetter<int> onServiceRequestSuccess;
  StreamSubscription<geo.ServiceStatus>? _geoLocationServiceStatusSubscription;

  void init() {
    getReservationServiceTypes();
    getPricingSettings();
  }

  void getPricingSettings() async {
    try {
      final pricingSettings =
          await userRepository.getPricingSettings(FetchPolicy.cachePreferably);
      final minPrice = state.serviceType == ServiceType.reservation
          ? pricingSettings.reservationServiceMinPrice
          : pricingSettings.otherServiceMinPrice;
      final newState = state.copyWith(
        pricingSettings: pricingSettings,
        price: minPrice.toDouble(),
      );
      emit(newState);
    } catch (error) {
      final newState = state.copyWith(
        pricingSettings: null,
        error: error,
      );
      emit(newState);
    }
  }

  void getReservationServiceTypes() async {
    try {
      final reservationServiceTypes =
          await userRepository.getReservationServiceTypes(
        FetchPolicy.cachePreferably,
      );

      final successState = state.copyWith(
        reservationServiceTypes: reservationServiceTypes,
      );
      emit(successState);
    } catch (error) {
      final failureState =
          state.copyWith(reservationServiceTypes: [], error: error);
      emit(failureState);
    }
  }

  // void requestServiceLocationPermission() async {
  //   final permission = await geo.Geolocator.requestPermission();
  //   if (permission == geo.LocationPermission.denied) {
  //     final newState = state.copyWith(
  //       locationServiceStatus: false,
  //     );
  //     emit(newState);
  //   }
  // }

  void serviceTypeChanged(ServiceType serviceType) {
    final newState = state.copyWith(
      serviceType: serviceType,
    );
    emit(newState);
  }

  void serviceTypeSelected(ReservationServiceType serviceType) {
    final newState = state.copyWith(
      selectedReservationServiceType: Dynamic.validated(serviceType),
    );
    emit(newState);
  }

  void onReservationNameChanged(String value) {
    final previousReservationName = state.reservationName;
    final shouldValidate = previousReservationName.isNotValid;
    final newState = state.copyWith(
      reservationName: shouldValidate
          ? Dynamic<String?>.validated(
              value,
              isRequired: true,
            )
          : Dynamic<String?>.unvalidated(value),
    );
    emit(newState);
  }

  void onReservationNameUnfocused() {
    final newState = state.copyWith(
      reservationName: Dynamic<String?>.validated(
        state.reservationName.value,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void onDatePicked(DateTime dateTime) async {
    final resetTimeState = state.copyWith(
      date: const Dynamic<DateTime?>.validated(null),
      time: const Dynamic<TimeOfDay?>.unvalidated(null),
    );
    emit(resetTimeState);
    // This is a workaround to fix the issue where the time picker is not reset
    await Future.delayed(const Duration(milliseconds: 1));
    final newState = state.copyWith(
      date: Dynamic<DateTime?>.validated(
        dateTime,
        isRequired: true,
      ),
      time: const Dynamic<TimeOfDay?>.unvalidated(null),
    );
    emit(newState);
  }

  void onTimeChanged(TimeOfDay? newValue) {
    final newState = state.copyWith(
      time: Dynamic<TimeOfDay?>.validated(
        newValue,
      ),
    );
    emit(newState);
  }

  void onPlaceNameChanged(String value) {
    final previousPlaceName = state.placeName;
    final shouldValidate = previousPlaceName.isNotValid;
    final newState = state.copyWith(
      placeName: shouldValidate
          ? Dynamic<String?>.validated(
              value,
              isRequired: true,
            )
          : Dynamic<String?>.unvalidated(value),
    );
    emit(newState);
  }

  void onPlaceNameUnfocused() {
    final newState = state.copyWith(
      placeName: Dynamic<String?>.validated(
        state.placeName.value,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void onAddressChanged(String value) {
    final previousAddress = state.address;
    final shouldValidate = previousAddress.isNotValid;
    final newState = state.copyWith(
      address: shouldValidate
          ? Dynamic<String?>.validated(
              value,
              isRequired: true,
            )
          : Dynamic<String?>.unvalidated(value),
    );
    emit(newState);
  }

  void onAddressUnfocused() {
    final newState = state.copyWith(
      address: Dynamic<String?>.validated(
        state.address.value,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void onLocationPickerTapped() {
    final newState = state.copyWith(
      locationPickingInProgress: true,
    );
    emit(newState);
  }

  void onLocationChanged(LatLng? latLng) {
    final newState = state.copyWith(
      location: Dynamic<LatLng?>.validated(
        latLng,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void onLocationConfirmed() {
    final newState = state.copyWith(
      locationPickingInProgress: false,
    );
    emit(newState);
  }

  void onIncrementPrice() {
    final newState = state.copyWith(
      price: state.price! + 10,
    );
    emit(newState);
  }

  void onDecrementPrice() {
    final minPrice = state.serviceType == ServiceType.reservation
        ? state.pricingSettings!.reservationServiceMinPrice
        : state.pricingSettings!.otherServiceMinPrice;
    if (state.price! <= minPrice) return;
    final newState = state.copyWith(
      price: state.price! - 10,
    );
    emit(newState);
  }

  void onAdditionalCommentsChanged(String value) {
    final newState = state.copyWith(
      additionalComments: Dynamic<String?>.unvalidated(value),
    );
    emit(newState);
  }

  void onSubmit() async {
    final reservationServiceType = Dynamic<ReservationServiceType?>.validated(
      state.selectedReservationServiceType.value,
      isRequired: true,
    );
    final reservationName = Dynamic<String?>.validated(
      state.reservationName.value,
      isRequired: true,
    );
    final date = Dynamic<DateTime>.validated(
      state.date.value,
      isRequired: true,
    );
    final placeName = Dynamic<String?>.validated(
      state.placeName.value,
      isRequired: true,
    );
    final address = Dynamic<String?>.validated(
      state.address.value,
      isRequired: true,
    );
    final location = Dynamic<LatLng?>.validated(
      state.location.value,
      isRequired: true,
    );

    final isReservationServiceType =
        state.serviceType == ServiceType.reservation;

    final isFormValid = Formz.validate([
      if (isReservationServiceType) ...[
        reservationServiceType,
        reservationName,
      ],
      date,
      placeName,
      address,
      location,
    ]);

    final newState = state.copyWith(
      selectedReservationServiceType: reservationServiceType,
      reservationName: reservationName,
      date: date,
      placeName: placeName,
      address: address,
      location: location,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        final requestId = await serviceRepository.requestService(
          serviceType: state.serviceType!,
          // price: 0,
          price: state.price!,
          coordinates: location.value!,
          placeName: placeName.value!,
          placeAddress: address.value!,
          reservedFor: reservationName.value,
          date: date.value!,
          time: state.time.value,
          reservationServiceType: reservationServiceType.value,
          additionalComments: state.additionalComments.value,
        );

        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
          requestId: requestId,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: error is! InsufficientBalanceException
              ? FormzSubmissionStatus.failure
              : FormzSubmissionStatus.initial,
          error: error,
        );
        emit(newState);
      }
    }
  }

  //ondispose
  @override
  Future<void> close() {
    _geoLocationServiceStatusSubscription?.cancel();
    return super.close();
  }
}
