class PaymobUrlBuilder {
  static const String _stagingBaseUrl =
      'https://stagingpayouts.paymobsolutions.com';

  // Use PAYMOB_BASE_URL dart-define to override (e.g. for production).
  static const String baseUrl = String.fromEnvironment(
    'PAYMOB_BASE_URL',
    defaultValue: _stagingBaseUrl,
  );

  String buildTokenUrl() => '$baseUrl/api/secure/o/token/';

  String buildDisburseUrl() => '$baseUrl/api/secure/disburse/';

  String buildTransactionInquiryUrl() =>
      '$baseUrl/api/secure/transaction/inquire/';

  String buildBudgetInquiryUrl() => '$baseUrl/api/secure/budget/inquire/';

  String buildCancelAmanUrl() => '$baseUrl/api/secure/transaction/aman/cancel/';
}
