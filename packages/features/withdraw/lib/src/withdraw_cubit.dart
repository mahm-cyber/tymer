import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'withdraw_state.dart';

class WithdrawCubit extends Cubit<WithdrawState> {
  WithdrawCubit({
    required this.userRepository,
    required this.walletRepository,
    required this.onBackTapped,
    required this.onProvideServiceTapped,
    required this.onSuccess,
  }) : super(
          WithdrawState(
            paymentMethodType: walletRepository
                .changeNotifier.withdrawMethods?.pickedPaymentMethodType,
          ),
        );

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final VoidCallback onBackTapped;
  final VoidCallback onProvideServiceTapped;
  final VoidCallback onSuccess;
  void onWithdrawAmountChanged(String? newValue) {
    final previousWithdrawAmount = state.withdrawAmount;
    final shouldValidate = previousWithdrawAmount.isNotValid;
    final newState = state.copyWith(
      withdrawAmount: shouldValidate
          ? Dynamic<String?>.validated(
              newValue,
              isRequired: true,
              checkIfNumber: true,
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
        checkIfNumber: true,
      ),
    );
    emit(newState);
  }

  void onWalletNumberChanged(String? newValue) {
    final previousWalletNumber = state.walletNumber;
    final shouldValidate = previousWalletNumber.isNotValid;
    final newState = state.copyWith(
      walletNumber: shouldValidate
          ? Dynamic<String?>.validated(
              newValue,
              isRequired: true,
              checkIfNumber: true,
              shouldCheckIfEgyptianMobile: true,
            )
          : Dynamic<String?>.unvalidated(newValue),
    );
    emit(newState);
  }

  void onWalletNumberUnfocused() {
    final newState = state.copyWith(
      walletNumber: Dynamic<String?>.validated(
        state.walletNumber.value,
        isRequired: true,
        checkIfNumber: true,
        shouldCheckIfEgyptianMobile: true,
      ),
    );
    emit(newState);
  }

  void onIbanNumberChanged(String? newValue) {
    final previousIbanNumber = state.ibanNumber;
    final shouldValidate = previousIbanNumber.isNotValid;
    final newState = state.copyWith(
      ibanNumber: shouldValidate
          ? Dynamic<String?>.validated(
              newValue,
              isRequired: true,
            )
          : Dynamic<String?>.unvalidated(newValue),
    );
    emit(newState);
  }

  void onIbanNumberUnfocused() {
    final newState = state.copyWith(
      ibanNumber: Dynamic<String?>.validated(
        state.ibanNumber.value,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void onBeneficiaryNameChanged(String? newValue) {
    final previousBeneficiaryName = state.beneficiaryName;
    final shouldValidate = previousBeneficiaryName.isNotValid;
    final newState = state.copyWith(
      beneficiaryName: shouldValidate
          ? Dynamic<String?>.validated(
              newValue,
              isRequired: true,
            )
          : Dynamic<String?>.unvalidated(newValue),
    );
    emit(newState);
  }

  void onBeneficiaryNameUnfocused() {
    final newState = state.copyWith(
      beneficiaryName: Dynamic<String?>.validated(
        state.beneficiaryName.value,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void onInstaPayAddressChanged(String? newValue) {
    final previousInstaPayAddress = state.instantPaymentAddress;
    final shouldValidate = previousInstaPayAddress.isNotValid;
    final newState = state.copyWith(
      instantPaymentAddress: shouldValidate
          ? Dynamic<String?>.validated(newValue)
          : Dynamic<String?>.unvalidated(newValue),
    );
    emit(newState);
  }

  void onInstaPayAddressUnfocused() {
    final newState = state.copyWith(
      instantPaymentAddress: Dynamic<String?>.validated(
        state.instantPaymentAddress.value,
        isRequired: true,
      ),
    );
    emit(newState);
  } 

  void onTeldaUsernameChanged(String? newValue) {
    final previousTeldaUsername = state.teldaUsername;
    final shouldValidate = previousTeldaUsername.isNotValid;
    final newState = state.copyWith(
      teldaUsername: shouldValidate
          ? Dynamic<String?>.validated(newValue)
          : Dynamic<String?>.unvalidated(newValue),
    );
    emit(newState);
  }

  void onTeldaUsernameUnfocused() { 
    final newState = state.copyWith(
      teldaUsername: Dynamic<String?>.validated(
        state.teldaUsername.value,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void onSubmit() async {
    final withdrawAmount = Dynamic<String?>.validated(
      state.withdrawAmount.value,
      isRequired: true,
      checkIfNumber: true,
    );

    final walletNumber = Dynamic<String?>.validated(
      state.walletNumber.value,
      isRequired: true,
      checkIfNumber: true,
      shouldCheckIfEgyptianMobile: true,
    );

    final instantPaymentAddress = Dynamic<String?>.validated(
      state.instantPaymentAddress.value,
      isRequired: true,
    );

    final teldaUsername = Dynamic<String?>.validated(
      state.teldaUsername.value,
      isRequired: true,
    );

    final ibanNumber = Dynamic<String?>.validated(
      state.ibanNumber.value,
      isRequired: true,
    );

    final beneficiaryName = Dynamic<String?>.validated(
      state.beneficiaryName.value,
      isRequired: true,
    );

    final isFormValid = Formz.validate([
      withdrawAmount,
      if (walletNumber.value != null) walletNumber,
      if (instantPaymentAddress.value != null) instantPaymentAddress,
      if (ibanNumber.value != null) ibanNumber,
      if (beneficiaryName.value != null) beneficiaryName,
      if (teldaUsername.value != null) teldaUsername,
    ]);

    final newState = state.copyWith(
      withdrawAmount: withdrawAmount,
      walletNumber: walletNumber,
      instantPaymentAddress: instantPaymentAddress,
      ibanNumber: ibanNumber,
      beneficiaryName: beneficiaryName,
      teldaUsername: teldaUsername,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await walletRepository.confirmWithdraw(
          paymentMethodType: walletRepository
              .changeNotifier.withdrawMethods!.pickedPaymentMethodType!,
          amount: int.parse(withdrawAmount.value!),
          walletNumber: walletNumber.value,
          instantPaymentAddress: instantPaymentAddress.value,
          teldaUsername: teldaUsername.value,
        );
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (error) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }

// @override
// Future<void> close() async {
//   return super.close();
// }
}
