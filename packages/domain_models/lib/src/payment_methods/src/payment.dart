enum PaymentStatus {
  pending,
  approved,
  rejected;

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
}

class Payment {
  const Payment({
    required this.id,
    required this.userId,
    required this.amount,
    this.ibanNumber,
    this.beneficiaryName,
    this.instantPaymentAddress,
    this.walletNumber,
    required this.status,
    this.proofImage,
    required this.updatedAt,
  });

  final int id;
  final int userId;
  final int amount;
  final String? ibanNumber;
  final String? beneficiaryName;
  final String? instantPaymentAddress;
  final String? walletNumber;
  final PaymentStatus status;
  final String? proofImage;
  final DateTime updatedAt;
}

class PaymentListPage {
  const PaymentListPage({
    required this.list,
    this.isLastPage,
  });

  final List<Payment> list;
  final bool? isLastPage;
}

enum PaymentType {
  withdraw,
  topup;
}
