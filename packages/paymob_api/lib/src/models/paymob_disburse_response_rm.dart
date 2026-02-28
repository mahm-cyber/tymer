/// Remote model for the Paymob instant disbursement response.
class PaymobDisburseResponseRM {
  const PaymobDisburseResponseRM({
    required this.transactionId,
    required this.status,
    this.disbursementData,
  });

  static const _transactionIdKey = 'transaction_id';
  static const _statusKey = 'status';
  static const _disbursementDataKey = 'disbursement_data';

  final String transactionId;
  final String status;
  final Map<String, dynamic>? disbursementData;

  factory PaymobDisburseResponseRM.fromJson(Map<String, dynamic> json) {
    return PaymobDisburseResponseRM(
      transactionId: json[_transactionIdKey]?.toString() ?? '',
      status: json[_statusKey]?.toString() ?? '',
      disbursementData: json[_disbursementDataKey] as Map<String, dynamic>?,
    );
  }
}
