class PaymobTopUpResult {
  const PaymobTopUpResult({
    required this.checkoutUrl,
    required this.transactionId,
  });

  final String checkoutUrl;
  final String transactionId;
}
