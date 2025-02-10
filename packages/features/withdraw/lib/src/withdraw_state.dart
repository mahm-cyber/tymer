part of 'withdraw_cubit.dart';

class WithdrawState extends Equatable {
  const WithdrawState({
    this.withdrawMethodType,
    this.withdrawMethods,
    this.withdrawAmount = const Dynamic<String?>.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.walletNumber = const Dynamic<String?>.unvalidated(),
    this.instantPaymentAddress = const Dynamic<String?>.unvalidated(),
    this.ibanNumber = const Dynamic<String?>.unvalidated(),
    this.beneficiaryName = const Dynamic<String?>.unvalidated(),
    this.teldaUsername = const Dynamic<String?>.unvalidated(),
    this.error,
  });

  final PaymentMethodType? withdrawMethodType;
  final PaymentMethods? withdrawMethods;
  final Dynamic<String?> withdrawAmount;
  final FormzSubmissionStatus submissionStatus;
  final Dynamic<String?> walletNumber;
  final Dynamic<String?> instantPaymentAddress;
  final Dynamic<String?> ibanNumber;
  final Dynamic<String?> beneficiaryName;
  final Dynamic<String?> teldaUsername;
  final dynamic error;

  

  WithdrawState copyWith({
    PaymentMethodType? withdrawMethodType,
    PaymentMethods? withdrawMethods,
    Dynamic<String?>? withdrawAmount,
    FormzSubmissionStatus? submissionStatus,
    Dynamic<String?>? walletNumber,
    Dynamic<String?>? instantPaymentAddress,
    Dynamic<String?>? ibanNumber,
    Dynamic<String?>? beneficiaryName,
    Dynamic<String?>? teldaUsername,
    dynamic error,
  }) {
    return WithdrawState(
      withdrawMethodType: withdrawMethodType ?? this.withdrawMethodType,
      withdrawMethods: withdrawMethods ?? this.withdrawMethods,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      walletNumber: walletNumber ?? this.walletNumber,
      instantPaymentAddress:
          instantPaymentAddress ?? this.instantPaymentAddress,
      ibanNumber: ibanNumber ?? this.ibanNumber,
      beneficiaryName: beneficiaryName ?? this.beneficiaryName,
      teldaUsername: teldaUsername ?? this.teldaUsername,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        withdrawMethodType,
        withdrawMethods,
        withdrawAmount,
        submissionStatus,
        walletNumber,
        instantPaymentAddress,
        ibanNumber,
        beneficiaryName,
        teldaUsername,
        error,
      ];
}
