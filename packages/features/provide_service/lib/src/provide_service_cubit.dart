import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

part 'provide_service_state.dart';

class ProvideServiceCubit extends Cubit<ProvideServiceState> {
  ProvideServiceCubit({
    required this.userRepository,
    required this.serviceRepository,
  }) : super(
          const ProvideServiceState(),
        );

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
}
