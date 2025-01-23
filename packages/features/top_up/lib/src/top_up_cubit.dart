import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';

part 'top_up_state.dart';

class TopUpCubit extends Cubit<TopUpState> {
  TopUpCubit({
    required this.userRepository,
    required this.onBackTapped,
    required this.onProvideServiceTapped,
  }) : super(
          const TopUpState(),
        );

  final UserRepository userRepository;
  final VoidCallback onBackTapped;
  final VoidCallback onProvideServiceTapped;

  void onTopUpAmountChanged(String? newValue) {
    final previousTopUpAmount = state.topUpAmount;
    final shouldValidate = previousTopUpAmount.isNotValid;
    final newState = state.copyWith(
      topUpAmount: shouldValidate
          ? Dynamic<String?>.validated(
              newValue,
              isRequired: true,
              isNumber: true,
            )
          : Dynamic<String?>.unvalidated(
              newValue,
            ),
    );
    emit(newState);
  }

  void onTopUpAmountUnfocused() {
    final newState = state.copyWith(
      topUpAmount: Dynamic<String?>.validated(
        state.topUpAmount.value,
        isRequired: true,
        isNumber: true,
      ),
    );

    emit(newState);
  }

  void onSubmit() async {
    final topUpAmount = Dynamic<String?>.validated(
      state.topUpAmount.value,
      isRequired: true,
      isNumber: true,
    );

    final isFormValid = Formz.validate([
      topUpAmount,
    ]);

    final newState = state.copyWith(
      topUpAmount: topUpAmount,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        // await userRepository.topUp(
        //   topUpAmount: double.parse(topUpAmount.value!),
        // );
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);

      } catch (error) {
        final newState = state.copyWith(
          topUpAmount: Dynamic<String?>.validated(
            topUpAmount.value,
            isRequired: true,
            isNumber: true,
          ),
          submissionStatus: FormzSubmissionStatus.failure,
        );
        emit(newState);
      }
    }
  }


// @override
// Future<void> close() async {
//   return super.close();
// }
}
