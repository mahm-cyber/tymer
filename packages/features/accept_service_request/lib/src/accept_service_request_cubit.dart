
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:service_repository/service_repository.dart';

part 'accept_service_request_state.dart';

class AcceptServiceRequestCubit extends Cubit<AcceptServiceRequestState> {
  AcceptServiceRequestCubit({
    required this.serviceRepository,
    required this.onAcceptServiceRequestSuccess,
  }) : super(
          AcceptServiceRequestState(
            service: serviceRepository.changeNotifier.serviceRequestDetails,
          ),
        ) {
    final serviceRequestDetails =
        serviceRepository.changeNotifier.serviceRequestDetails;
    debugPrint('serviceRequestDetails: ${serviceRequestDetails?.id}');
  }

  final ServiceRepository serviceRepository;
  final VoidCallback onAcceptServiceRequestSuccess;

  void onViewServiceOnMap() async {
    final myLocation = await serviceRepository.getUserLocation();
    emit(
      state.copyWith(
        myLocation: myLocation,
        isViewingLocation: true,
      ),
    );
  }

  void closeMap() {
    emit(
      state.copyWith(
        isViewingLocation: false,
      ),
    );
  }

  void onSubmit() async {
    emit(state.copyWith(submissionStatus: SubmissionStatus.submitting));
    try {
      await serviceRepository.acceptServiceRequest(
        serviceRequestId: state.service!.id!,
      );
      emit(state.copyWith(submissionStatus: SubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(submissionStatus: SubmissionStatus.failure));
    }
  }
}
