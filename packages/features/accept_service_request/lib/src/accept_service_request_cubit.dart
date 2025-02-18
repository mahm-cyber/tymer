import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:service_repository/service_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'accept_service_request_state.dart';

class AcceptServiceRequestCubit extends Cubit<AcceptServiceRequestState> {
  AcceptServiceRequestCubit({
    required this.serviceRepository,
    required this.userRepository,
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
  final UserRepository userRepository;
  final ValueSetter<int> onAcceptServiceRequestSuccess;


  void onViewServiceOnMap() async {
    try {
      serviceRepository.launchMap(
        state.service!.location.coordinates[1],
        state.service!.location.coordinates[0],
      );
    } catch (e) {
      rethrow;
    }
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
    } catch (error) {
      emit(state.copyWith(
        submissionStatus: SubmissionStatus.failure,
        error: error,
      ));
    }
  }
}
