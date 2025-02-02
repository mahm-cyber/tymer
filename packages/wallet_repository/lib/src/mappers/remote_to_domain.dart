import 'package:domain_models/domain_models.dart';
import 'package:tymer_api/tymer_api.dart';
export 'package:tymer_api/tymer_api.dart';
export 'package:domain_models/domain_models.dart';

extension PaymentMethodRMToDM on String {
  PaymentMethodType toDomainModel() {
    switch (toLowerCase()) {
      case 'bank_card':
        return PaymentMethodType.bankCard;
      case 'vodafone_cash':
        return PaymentMethodType.vodafoneCash;
      case 'orange_cash':
        return PaymentMethodType.orangeCash;
      case 'etisalat_cash':
        return PaymentMethodType.etisalatCash;
      case 'instapay':
        return PaymentMethodType.instaPay;
      case 'bank_transfer':
        return PaymentMethodType.bankTransfer;
      default:
        throw Exception('Unknown payment method');
    }
  }
}

extension PaymentMethodsRMToDM on PaymentMethodsRM {
  PaymentMethods toDomainModel() {
    return PaymentMethods(
      vodafoneCash: VodafoneCash(
        enabled: vodafoneCashEnabled,
        walletNumber: vodafoneCashWalletNumber,
        message: LocalizedMessage(
          ar: vodafoneCashMessage['ar']!,
          en: vodafoneCashMessage['en']!,
        ),
      ),
      orangeCash: OrangeCash(
        enabled: orangeCashEnabled,
        walletNumber: orangeCashWalletNumber,
        message: LocalizedMessage(
          ar: orangeCashMessage['ar']!,
          en: orangeCashMessage['en']!,
        ),
      ),
      etisalatCash: EtisalatCash(
        enabled: etisalatCashEnabled,
        walletNumber: etisalatCashWalletNumber,
        message: LocalizedMessage(
          ar: etisalatCashMessage['ar']!,
          en: etisalatCashMessage['en']!,
        ),
      ),
      instaPay: InstaPay(
        enabled: instapayEnabled,
        instantPaymentAddress: instapayInstantPaymentAddress,
        message: LocalizedMessage(
          ar: instapayMessage['ar']!,
          en: instapayMessage['en']!,
        ),
      ),
      telda: Telda(
        enabled: teldaEnabled,
        username: teldaUsername,
        message: LocalizedMessage(
          ar: teldaMessage['ar']!,
          en: teldaMessage['en']!,
        ),
      ),
      bankTransfer: BankTransfer(
        enabled: bankTransferEnabled,
        beneficiaryName: bankTransferBeneficiaryName,
        beneficiaryAddress: bankTransferBeneficiaryAddress,
        bankName: bankTransferBankName,
        iban: bankTransferIban,
        swiftCode: bankTransferSwiftCode,
        message: LocalizedMessage(
          ar: bankTransferMessage['ar']!,
          en: bankTransferMessage['en']!,
        ),
      ),
    );
  }
}

extension PaymentRMToDM on PaymentRM {
  static PaymentStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return PaymentStatus.pending;
      case 'approved':
        return PaymentStatus.approved;
      case 'rejected':
        return PaymentStatus.rejected;
      default:
        throw Exception('Unknown payment status: $status');
    }
  }

  Payment toDomainModel() {
    return Payment(
      id: id,
      userId: userId,
      amount: double.parse(amount).toInt(),
      ibanNumber: ibanNumber,
      beneficiaryName: beneficiaryName,
      instantPaymentAddress: instantPaymentAddress,
      walletNumber: walletNumber,
      status: fromString(status),
      proofImage: proofImage,
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}

extension PaymentListPageRMToDM on PaymentListPageRM {
  PaymentListPage toDomainModel() {
    return PaymentListPage(
      list: list.map((payment) => payment.toDomainModel()).toList(),
      isLastPage: isLastPage,
    );
  }
}

extension InAppTransactionRMToDM on InAppTransactionRM {
  static InAppTransactionStatus statusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return InAppTransactionStatus.pending;
      case 'completed':
        return InAppTransactionStatus.completed;
      case 'rejected':
        return InAppTransactionStatus.rejected;
      default:
        throw Exception('Unknown in-app transaction status: $status');
    }
  }

  static InAppTransactionType typeFromString(String type) {
    switch (type.toLowerCase()) {
      case 'earning':
        return InAppTransactionType.earning;
      case 'payout':
        return InAppTransactionType.payout;
      default:
        throw Exception('Unknown in-app transaction type: $type');
    }
  }

  InAppTransaction toDomainModel() {
    return InAppTransaction(
      id: id,
      userId: userId,
      amount: double.parse(amount).toInt(),
      status: statusFromString(status),
      type: typeFromString(type),
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}

extension InAppTransactionListPageRMToDM on InAppTransactionListPageRM {
  InAppTransactionListPage toDomainModel() {
    return InAppTransactionListPage(
      list: list.map((transaction) => transaction.toDomainModel()).toList(),
      isLastPage: isLastPage!,
    );
  }
}
