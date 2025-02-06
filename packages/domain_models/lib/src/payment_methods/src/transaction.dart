enum TransactionStatus {
  pending,
  completed,
  cancelled,
  underReview,
  refunded,
  failed;
}

enum TransactionType {
  withdraw,
  payout,
  earning,
  topup,
  refund,
  bonus,
  chargeback;
}

class Transaction {
  const Transaction({
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
  final TransactionType type;
  final TransactionStatus status;
  final int amount;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class TransactionListPage {
  const TransactionListPage({
    required this.list,
    required this.isLastPage,
  });

  final List<Transaction> list;
  final bool isLastPage;
}
