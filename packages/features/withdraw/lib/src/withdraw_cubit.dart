import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';

part 'withdraw_state.dart';

class WithdrawCubit extends Cubit<WithdrawState> {
  WithdrawCubit({
    required this.userRepository,
    required this.onBackTapped,
    required this.onProvideServiceTapped,
  }) : super(
          const WithdrawState(),
        );

  final UserRepository userRepository;
  final VoidCallback onBackTapped;
  final VoidCallback onProvideServiceTapped;

  void onWithdrawAmountChanged(String? newValue) {
    final previousWithdrawAmount = state.withdrawAmount;
    final shouldValidate = previousWithdrawAmount.isNotValid;
    final newState = state.copyWith(
      withdrawAmount: shouldValidate
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

  void onWithdrawAmountUnfocused() {
    final newState = state.copyWith(
      withdrawAmount: Dynamic<String?>.validated(
        state.withdrawAmount.value,
        isRequired: true,
        isNumber: true,
      ),
    );

    emit(newState);
  }

  void onSubmit() async {
    final withdrawAmount = Dynamic<String?>.validated(
      state.withdrawAmount.value,
      isRequired: true,
      isNumber: true,
    );

    final isFormValid = Formz.validate([
      withdrawAmount,
    ]);

    final newState = state.copyWith(
      withdrawAmount: withdrawAmount,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        // await userRepository.withdraw(
        //   withdrawAmount: double.parse(withdrawAmount.value!),
        // );
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);

      } catch (error) {
        final newState = state.copyWith(
          withdrawAmount: Dynamic<String?>.validated(
            withdrawAmount.value,
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
