class PaymobSyncResult {
  const PaymobSyncResult({
    required this.isSuccess,
    required this.isPending,
    required this.status,
    required this.message,
  });

  final bool isSuccess;
  final bool isPending;
  final String status;
  final String message;
}
