import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'choose_top_up_method_state.dart';

class ChooseTopUpMethodCubit extends Cubit<ChooseTopUpMethodState> {
  ChooseTopUpMethodCubit({
    required this.userRepository,
    required this.walletRepository,
    required this.onTopUpMethodTapped,
  }) : super(const ChooseTopUpMethodState()) {
    getPaymentMethods();
  }

  final UserRepository userRepository;
  final WalletRepository walletRepository;
  final VoidCallback onTopUpMethodTapped;

  Future<void> getPaymentMethods() async {
    final loadingState =
        state.copyWith(paymentMethodsLoadingStatus: LoadingStatus.loading);
    emit(loadingState);
    try {
      final paymentMethods = await walletRepository.getPaymentMethods();
      final successState = state.copyWith(
        paymentMethods: paymentMethods,
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
    onTopUpMethodTapped();
    final paymentMethods = state.paymentMethods!.copyWith(
      pickedPaymentMethodType: paymentMethodType,
    );
    walletRepository.changeNotifier.setPaymentMethods(paymentMethods);
  }

// @override
// Future<void> close() async {
//
//
//   return super.close();
// }
}
