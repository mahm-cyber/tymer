import 'package:wallet_repository/src/mappers/mappers.dart';
import 'package:wallet_repository/src/wallet_change_notifier.dart';

export 'src/mappers/remote_to_domain.dart';

class WalletRepository {
  WalletRepository({
    required this.remoteApi,
  }) : changeNotifier = WalletChangeNotifier();

  final TymerApi remoteApi;
  final WalletChangeNotifier changeNotifier;

  Future<PaymentMethods> getPaymentMethods() async {
    final paymentMethods = await remoteApi.getPaymentMethods();
    final paymentMethodsDomain = paymentMethods.toDomainModel();
    return paymentMethodsDomain;
  }
}
