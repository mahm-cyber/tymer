/// Remote model representing a single transaction's status from the inquiry endpoint.
class PaymobTransactionStatusRM {
  const PaymobTransactionStatusRM({
    required this.transactionId,
    required this.status,
    this.issuer,
    this.amount,
    this.msisdn,
    this.createdAt,
  });

  static const _transactionIdKey = 'transaction_id';
  static const _statusKey = 'status';
  static const _issuerKey = 'issuer';
  static const _amountKey = 'amount';
  static const _msisdnKey = 'msisdn';
  static const _createdAtKey = 'created_at';

  final String transactionId;
  final String status;
  final String? issuer;
  final String? amount;
  final String? msisdn;
  final String? createdAt;

  factory PaymobTransactionStatusRM.fromJson(Map<String, dynamic> json) {
    return PaymobTransactionStatusRM(
      transactionId: json[_transactionIdKey]?.toString() ?? '',
      status: json[_statusKey]?.toString() ?? '',
      issuer: json[_issuerKey] as String?,
      amount: json[_amountKey]?.toString(),
      msisdn: json[_msisdnKey] as String?,
      createdAt: json[_createdAtKey] as String?,
    );
  }
}
