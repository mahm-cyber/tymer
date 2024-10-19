import 'dart:async';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_repository/service_repository.dart';

part 'fulfill_service_request_state.dart';

class FulfillServiceRequestCubit extends Cubit<FulfillServiceRequestState> {
  FulfillServiceRequestCubit({
    required this.serviceRepository,
  })  : _imagePicker = ImagePicker(),
        super(
          FulfillServiceRequestState(
            service: serviceRepository.changeNotifier.serviceRequestDetails,
          ),
        );

  final ServiceRepository serviceRepository;
  final StreamController<String> carImageFileNameSC = StreamController();
  final ImagePicker _imagePicker;

  // onWaitingTimeUnfocused
  // onWaitingTimeChanged
  // onReservationNumberUnfocused
  // onReservationNumberChanged

  void onWaitingTimeChanged(String? newValue) {
    final previousWaitingTime = state.waitingTime;
    final shouldValidate = previousWaitingTime.isNotValid;
    final newState = state.copyWith(
      waitingTime: shouldValidate
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

  void onWaitingTimeUnfocused() {
    final newState = state.copyWith(
      waitingTime: Dynamic<String>.validated(
        state.waitingTime.value,
        isRequired: true,
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
      source: ImageSource.camera,
    );
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
    emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
    try {
      await serviceRepository.fulfillServiceRequest(
        serviceRequestId: state.service!.id!,
      );
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
    }
  }
}
