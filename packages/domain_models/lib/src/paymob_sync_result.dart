class PaymobSyncResult {
  const PaymobSyncResult({
    required this.isSuccess,
    required this.status,
    required this.message,
  });

  final bool isSuccess;
  final String status;
  final String message;
}
