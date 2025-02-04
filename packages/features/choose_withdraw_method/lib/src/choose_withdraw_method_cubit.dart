import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'choose_withdraw_method_state.dart';

class ChooseWithdrawMethodCubit extends Cubit<ChooseWithdrawMethodState> {
  ChooseWithdrawMethodCubit({
    required this.userRepository,
    required this.walletRepository,
    required this.onWithdrawMethodTapped,
    required this.onWithdrawalPaymentHistoryTapped,
  }) : super(const ChooseWithdrawMethodState()) {
    getWithdrawMethods();
  }

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final VoidCallback onWithdrawMethodTapped;
  final VoidCallback onWithdrawalPaymentHistoryTapped;
  Future<void> getWithdrawMethods() async {
    final loadingState =
        state.copyWith(paymentMethodsLoadingStatus: LoadingStatus.loading);
    emit(loadingState);
    try {
      final withdrawMethods =
          await walletRepository.getPaymentMethods(TransactionType.withdraw);
      final successState = state.copyWith(
        paymentMethods: withdrawMethods,
        paymentMethodsLoadingStatus: LoadingStatus.success,
      );
      emit(successState);
    } catch (e) {
      final failureState = state.copyWith(
        paymentMethodsLoadingStatus: LoadingStatus.failure,
      );
      emit(failureState);
    }
  }

  Future<void> setPaymentMethodType(PaymentMethodType paymentMethodType) async {
    onWithdrawMethodTapped();
    final paymentMethods = state.paymentMethods!.copyWith(
      pickedPaymentMethodType: paymentMethodType,
    );
    walletRepository.changeNotifier.setWithdrawMethods(paymentMethods);
  }
}
