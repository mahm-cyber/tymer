import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';


part 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  InitialCubit({
    required this.userRepository,
  }) : super(
          const InitialState(),
        );

  final UserRepository userRepository;
}
