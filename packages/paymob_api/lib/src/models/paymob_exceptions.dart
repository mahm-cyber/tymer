/// Exception thrown when OAuth2 token generation or refresh fails.
class PaymobAuthFailedTymerException implements Exception {
  const PaymobAuthFailedTymerException([this.message]);
  final String? message;
}

/// Exception thrown when the disbursement request fails (rejected by Paymob).
class PaymobDisburseFailedTymerException implements Exception {
  const PaymobDisburseFailedTymerException([this.message]);
  final String? message;
}

/// Exception thrown when the account has insufficient budget for the disbursement.
class PaymobInsufficientBudgetTymerException implements Exception {
  const PaymobInsufficientBudgetTymerException();
}

/// Exception thrown when transaction inquiry fails.
class PaymobTransactionInquiryFailedTymerException implements Exception {
  const PaymobTransactionInquiryFailedTymerException([this.message]);
  final String? message;
}
