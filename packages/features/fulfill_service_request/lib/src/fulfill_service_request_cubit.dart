import 'dart:async';
import 'dart:io';
import 'package:dispute_repository/dispute_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_repository/service_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'fulfill_service_request_state.dart';

class FulfillServiceRequestCubit extends Cubit<FulfillServiceRequestState> {
  FulfillServiceRequestCubit({
    required this.requestId,
    required this.disputeRepository,
    required this.serviceRepository,
    required this.userRepository,
    required this.onNavigateToProvideService,
    required this.onServiceDisputed,
    required this.onBackButtonPressed,
  })  : _imagePicker = ImagePicker(),
        super(
          FulfillServiceRequestState(
            service: serviceRepository.changeNotifier.serviceRequestDetails,
          ),
        ) {
    init();
  }

  final int requestId;
  final DisputeRepository disputeRepository;
  final ServiceRepository serviceRepository;
  final UserRepository userRepository;
  final VoidCallback onNavigateToProvideService;
  final VoidCallback onBackButtonPressed;
  final ValueSetter<int> onServiceDisputed;
  final StreamController<String> imageFileNameSC = StreamController();
  final ImagePicker _imagePicker;
  Timer? _awaitRequestConfirmationTimer;

  void init() async {
    final service = serviceRepository.changeNotifier.serviceRequestDetails;
    final isPendingReview = service?.status == ServiceStatus.pendingReview;
    final isCompleted = service?.status == ServiceStatus.completed;
    final loadingState = state.copyWith(fetchStatus: FetchStatus.loading);
    emit(loadingState);
    final userToken = await userRepository.getUserToken();
    final tokenState = state.copyWith(userToken: userToken);
    emit(tokenState);

    final fetchedService = await getService();

    if (isPendingReview || isCompleted) {
      final newState = state.copyWith(
        submissionStatus:
            isPendingReview ? FormzSubmissionStatus.inProgress : null,
      );
      emit(newState);
      // final fetchedService = await getService();
      final newStateWithResponse = state.copyWith(
        service: fetchedService,
      );
      emit(newStateWithResponse);
      if (isPendingReview) pollRequestConfirmation();
    }
  }

  Future<Service> getService() async {
    // final loading = state.copyWith(fetchStatus: FetchStatus.loading);
    // emit(loading);
    try {
      final service = await serviceRepository.getServiceRequest(
        requestId: requestId,
      );
      final loaded = state.copyWith(
        fetchStatus: FetchStatus.success,
        service: service,
      );
      if (!isClosed) emit(loaded);
      return service;
    } catch (error) {
      final errorState = state.copyWith(fetchStatus: FetchStatus.failure);
      if (!isClosed) emit(errorState);
      rethrow;
    }
  }

  void pollRequestConfirmation({
    Dynamic<TimeOfDay?>? time,
    Dynamic<DateTime?>? day,
    Dynamic<String>? reservationNumber,
  }) async {
    _awaitRequestConfirmationTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) async {
      final service = await getService();
      if (service.status == ServiceStatus.completed) {
        if (!isClosed) {
          emit(
            FulfillServiceRequestState(
              time: time ?? state.time,
              day: day ?? state.day,
              reservationNumber: reservationNumber ?? state.reservationNumber,
              additionalDetails: state.additionalDetails,
              file: state.file,
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

  void onDayChanged(DateTime? newValue) {
    final serviceType = state.service?.type;
    final isReservationService = serviceType == ServiceType.reservation;

    final newState = state.copyWith(
      day: Dynamic<DateTime?>.validated(
        newValue,
        isRequired: isReservationService ? true : false,
      ),
    );
    emit(newState);
  }

  void onTimeChanged(TimeOfDay? newValue) {
    final serviceType = state.service?.type;
    final isReservationService = serviceType == ServiceType.reservation;
    final newState = state.copyWith(
      time: Dynamic<TimeOfDay?>.validated(
        newValue,
        isRequired: isReservationService ? true : false,
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
      source: ImageSource.gallery,
    );
    if (xFile != null) {
      final file = File(xFile.path);
      onImagePicked(
        xFile.name,
        file,
      );
    }
  }

  Future<void> capturePhoto() async {
    XFile? xFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 35,
    );
    if (xFile != null) {
      final file = File(xFile.path);
      onImagePicked(
        xFile.name,
        file,
      );
    }
  }

  void onImagePicked(
    String carImageFileName,
    File? file,
  ) {
    //image more than 1 mb
    final validatedImageBytes = FileSize<File?>.validated(
      file,
      sizeLimitInKb: 1024,
    );
    final carImagePicked = state.copyWith(
      isImagePickerBottomSheetVisible: false,
      file: validatedImageBytes,
    );
    emit(carImagePicked);
    imageFileNameSC.add(carImageFileName);
  }

  void deletePickedImage() {
    final imageDeletedState = state.copyWith(
      file: const FileSize<File?>.unvalidated(null),
    );
    emit(imageDeletedState);
    imageFileNameSC.add('');
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
    final image = state.file.value != null
        ? FileSize<File>.validated(
            state.file.value,
            sizeLimitInKb: 1024,
          )
        : null;
    final isFormValid = Formz.validate([
      reservationNumber,
      day,
      time,
      if (image != null) image,
    ]);
    final newState = state.copyWith(
      reservationNumber: reservationNumber,
      day: day,
      time: time,
      file: image,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );
    emit(newState);

    if (isFormValid) {
      final userLocation = await userRepository.getUserLocation();
      if (userLocation == null) {
        final initialState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.initial,
        );
        emit(initialState);
        return;
      }
      final userLocationDM = LocationDM(
        type: 'Point',
        coordinates: [
          userLocation.longitude!,
          userLocation.latitude!,
        ],
      );
      try {
        await serviceRepository.fulfillServiceRequest(
          userLocation: userLocationDM,
          serviceRequestDetails: state.service!,
          reservationNumber: reservationNumber.value,
          day: day.value,
          time: time.value,
          additionalDetails: state.additionalDetails,
          imageBytes: state.file.value?.readAsBytesSync(),
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

  void onServiceRequestDisputed() {
    disputeRepository.changeNotifier.setDisputeChatUserType(UserType.provider);
    onServiceDisputed(state.service!.dispute!.id);
  }

  @override
  Future<void> close() async {
    _awaitRequestConfirmationTimer?.cancel();
    imageFileNameSC.close();
    serviceRepository.changeNotifier.setShouldReFetchServices(true);
    serviceRepository.changeNotifier.clearServiceRequest();
    super.close();
  }
}
