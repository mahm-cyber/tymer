part of 'withdraw_cubit.dart';

class WithdrawState extends Equatable {
  const WithdrawState({
    this.paymentMethodType,
    this.withdrawMethods,
    this.withdrawAmount = const Dynamic<String?>.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.walletNumber = const Dynamic<String?>.unvalidated(),
    this.instantPaymentAddress = const Dynamic<String?>.unvalidated(),
    this.ibanNumber = const Dynamic<String?>.unvalidated(),
    this.beneficiaryName = const Dynamic<String?>.unvalidated(),
    this.teldaUsername = const Dynamic<String?>.unvalidated(),
  });

  final PaymentMethodType? paymentMethodType;
  final PaymentMethods? withdrawMethods;
  final Dynamic<String?> withdrawAmount;
  final FormzSubmissionStatus submissionStatus;
  final Dynamic<String?> walletNumber;
  final Dynamic<String?> instantPaymentAddress;
  final Dynamic<String?> ibanNumber;
  final Dynamic<String?> beneficiaryName;
  final Dynamic<String?> teldaUsername;

  WithdrawState copyWith({
    PaymentMethodType? paymentMethodType,
    PaymentMethods? withdrawMethods,
    Dynamic<String?>? withdrawAmount,
    FormzSubmissionStatus? submissionStatus,
    Dynamic<String?>? walletNumber,
    Dynamic<String?>? instantPaymentAddress,
    Dynamic<String?>? ibanNumber,
    Dynamic<String?>? beneficiaryName,
    Dynamic<String?>? teldaUsername,
  }) {
    return WithdrawState(
      paymentMethodType: paymentMethodType ?? this.paymentMethodType,
      withdrawMethods: withdrawMethods ?? this.withdrawMethods,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      walletNumber: walletNumber ?? this.walletNumber,
      instantPaymentAddress:
          instantPaymentAddress ?? this.instantPaymentAddress,
      ibanNumber: ibanNumber ?? this.ibanNumber,
      beneficiaryName: beneficiaryName ?? this.beneficiaryName,
      teldaUsername: teldaUsername ?? this.teldaUsername,
    );
  }

  @override
  List<Object?> get props => [
        paymentMethodType,
        withdrawMethods,
        withdrawAmount,
        submissionStatus,
        walletNumber,
        instantPaymentAddress,
        ibanNumber,
        beneficiaryName,
        teldaUsername,
      ];
}
