import 'dart:async';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_repository/service_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'fulfill_service_request_state.dart';

class FulfillServiceRequestCubit extends Cubit<FulfillServiceRequestState> {
  FulfillServiceRequestCubit({
    required this.serviceRepository,
    required this.userRepository,
    required this.onNavigateToProvideService,
  })  : _imagePicker = ImagePicker(),
        super(
          FulfillServiceRequestState(
            service: serviceRepository.changeNotifier.serviceRequestDetails,
          ),
        ) {
    init();
  }

  final ServiceRepository serviceRepository;
  final UserRepository userRepository;
  final VoidCallback onNavigateToProvideService;
  final StreamController<String> carImageFileNameSC = StreamController();
  final ImagePicker _imagePicker;
  Timer? _awaitRequestConfirmationTimer;

  void init() async {
    final service = serviceRepository.changeNotifier.serviceRequestDetails;
    final isPendingReview = service?.status == ServiceStatus.pendingReview;
    final isCompleted = service?.status == ServiceStatus.completed;
    if (isPendingReview || isCompleted) {
      final newState = state.copyWith(
        submissionStatus:
            isPendingReview ? FormzSubmissionStatus.inProgress : null,
      );
      emit(newState);
      final freshService =
          await serviceRepository.getServiceRequest(requestId: service!.id!);
      final userToken = await userRepository.getUserToken();
      final newStateWithResponse = state.copyWith(
        service: freshService,
        userToken: userToken,
      );
      emit(newStateWithResponse);
      if (isPendingReview) pollRequestConfirmation();
    }
  }

  void onDayChanged(DateTime? newValue) {
    final newState = state.copyWith(
      day: Dynamic<DateTime?>.validated(
        newValue,
      ),
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

  void onReservationNumberChanged(String? newValue) {
    final previousReservationNumber = state.reservationNumber;
    final shouldValidate = previousReservationNumber.isNotValid;
    final newState = state.copyWith(
      reservationNumber: shouldValidate
          ? Dynamic<String>.validated(
              newValue,
              isRequired: true,
            )
          : Dynamic<String>.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onReservationNumberUnfocused() {
    final newState = state.copyWith(
      reservationNumber: Dynamic<String>.validated(
        state.reservationNumber.value,
        isRequired: true,
      ),
    );

    emit(newState);
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

  void onImagePickerTapped() {
    final imagePickerBottomSheetVisibleState = state.copyWith(
      isImagePickerBottomSheetVisible: true,
    );
    emit(imagePickerBottomSheetVisibleState);
  }

  Future<void> pickImageFromGallery() async {
    XFile? xFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 30);
    if (xFile != null) {
      final imageBytes = await xFile.readAsBytes();
      onImagePicked(
        xFile.name,
        imageBytes,
      );
      emit(
        state.copyWith(
          isImagePickerBottomSheetVisible: false,
          imageBytes: imageBytes,
        ),
      );
    }
  }

  Future<void> capturePhoto() async {
    XFile? xFile = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 30);
    if (xFile != null) {
      final imageBytes = await xFile.readAsBytes();
      onImagePicked(
        xFile.name,
        imageBytes,
      );
      emit(
        state.copyWith(
          isImagePickerBottomSheetVisible: false,
          imageBytes: imageBytes,
        ),
      );
    }
  }

  void onImagePicked(
    String carImageFileName,
    Uint8List? imageBytes,
  ) {
    final carImagePicked = state.copyWith(imageBytes: imageBytes);
    emit(carImagePicked);
    carImageFileNameSC.add(carImageFileName);
  }

  void onImagePickerBottomSheetClosed() {
    final imagePickerBottomSheetClosedState = state.copyWith(
      isImagePickerBottomSheetVisible: false,
    );
    emit(imagePickerBottomSheetClosedState);
  }

  void onAdditionalDetailsChanged(String value) {
    final additionalDetailsChangedState = state.copyWith(
      additionalDetails: value,
    );
    emit(additionalDetailsChangedState);
  }

  void onSubmit() async {
    final serviceType = state.service!.type;
    final isOtherService = serviceType == ServiceType.other;
    final isReservationService = serviceType == ServiceType.reservation;
    final reservationNumber = Dynamic<String>.validated(
      state.reservationNumber.value,
      isRequired: isReservationService ? true : false,
    );
    final day = Dynamic<DateTime?>.validated(
      state.day.value,
      isRequired: isReservationService ? true : false,
    );
    final time = Dynamic<TimeOfDay?>.validated(
      state.time.value,
      isRequired:
          isReservationService || (isOtherService && state.day.value != null)
              ? true
              : false,
    );

    final isFormValid = Formz.validate([
      reservationNumber,
      day,
      time,
    ]);

    final newState = state.copyWith(
      reservationNumber: reservationNumber,
      day: day,
      time: time,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );
    emit(newState);
    if (isFormValid) {
      try {
        await serviceRepository.fulfillServiceRequest(
          serviceRequestDetails: state.service!,
          reservationNumber: reservationNumber.value,
          day: day.value,
          time: time.value,
          additionalDetails: state.additionalDetails,
          imageBytes: state.imageBytes,
        );

        pollRequestConfirmation(
          time: time,
          day: day,
          reservationNumber: reservationNumber,
        );
      } catch (e) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }

  void pollRequestConfirmation({
    Dynamic<TimeOfDay?>? time,
    Dynamic<DateTime?>? day,
    Dynamic<String>? reservationNumber,
  }) async {
    _awaitRequestConfirmationTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) async {
      final service = await serviceRepository.getServiceRequest(
          requestId: state.service!.id!);
      if (service.status == ServiceStatus.completed) {
        if (!isClosed) {
          emit(
            FulfillServiceRequestState(
              time: time ?? state.time,
              day: day ?? state.day,
              reservationNumber: reservationNumber ?? state.reservationNumber,
              additionalDetails: state.additionalDetails,
              imageBytes: state.imageBytes,
              service: state.service,
              userToken: state.userToken,
              isImagePickerBottomSheetVisible:
                  state.isImagePickerBottomSheetVisible,
              submissionStatus: FormzSubmissionStatus.success,
            ),
          );
        }
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() async {
    _awaitRequestConfirmationTimer?.cancel();
    carImageFileNameSC.close();
    super.close();
  }
}
