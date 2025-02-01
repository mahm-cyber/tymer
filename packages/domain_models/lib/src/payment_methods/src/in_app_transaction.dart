enum InAppTransactionStatus {
  pending,
  completed,
  rejected;
}

enum InAppTransactionType {
  earning,
  payout;
}

class InAppTransaction {
  const InAppTransaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int userId;
  final InAppTransactionType type;
  final InAppTransactionStatus status;
  final int amount;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class InAppTransactionListPage {
  const InAppTransactionListPage({
    required this.list,
    required this.isLastPage,
  });

  final List<InAppTransaction> list;
  final bool isLastPage;
}
