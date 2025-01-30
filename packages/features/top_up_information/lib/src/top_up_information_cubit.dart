import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:wallet_repository/wallet_repository.dart';

part 'top_up_information_state.dart';

class TopUpInformationCubit extends Cubit<TopUpInformationState> {
  TopUpInformationCubit({
    required this.userRepository,
    required this.walletRepository,
  }) : super(
          TopUpInformationState(
            paymentMethods: walletRepository.changeNotifier.paymentMethods!,
          ),
        );

  final UserRepository userRepository;
  final WalletRepository walletRepository;
}
