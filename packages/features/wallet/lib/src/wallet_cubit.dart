import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';
part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit({
    required this.userRepository,
    required this.walletRepository,
    required this.onTopUpTapped,
    required this.onWithdrawTapped,
  }) : super(
          const WalletState(),
        );

  final UserRepository userRepository;
  final VoidCallback onTopUpTapped;
  final VoidCallback onWithdrawTapped;
  final WalletRepository walletRepository;
  Future<void> onNavigateToWithdrawTapped() async {
    walletRepository.changeNotifier.setPaymentType(PaymentType.withdraw);
    onWithdrawTapped();
  }

  Future<void> onNavigateToTopUpTapped() async {
    walletRepository.changeNotifier.setPaymentType(PaymentType.topup);
    onTopUpTapped();
  }

  // @override
  // Future<void> close() async {
  //
  //
  //   return super.close();
// }
}
