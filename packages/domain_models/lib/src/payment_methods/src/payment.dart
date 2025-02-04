enum PaymentStatus {
  pending,
  approved,
  rejected;
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


