/// Domain model representing a completed Paymob disbursement.
class PaymobDisbursement {
  const PaymobDisbursement({
    required this.transactionId,
    required this.status,
    required this.issuer,
    required this.amount,
    required this.msisdn,
  });

  final String transactionId;
  final String status;
  final String issuer;
  final double amount;
  final String msisdn;
}

/// Domain model for the Paymob account budget (balance).
class PaymobBudget {
  const PaymobBudget({
    required this.availableBalance,
    this.currency,
  });

  final double availableBalance;
  final String? currency;
}

/// Domain model for a transaction status result.
class PaymobTransactionStatus {
  const PaymobTransactionStatus({
    required this.transactionId,
    required this.status,
    this.issuer,
    this.amount,
    this.msisdn,
    this.createdAt,
  });

  final String transactionId;
  final String status;
  final String? issuer;
  final String? amount;
  final String? msisdn;
  final String? createdAt;
}
