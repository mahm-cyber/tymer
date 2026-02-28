/// Remote model for the Paymob budget (balance) inquiry response.
class PaymobBudgetRM {
  const PaymobBudgetRM({
    required this.availableBalance,
    this.currency,
  });

  static const _availableBalanceKey = 'available_balance';
  static const _currencyKey = 'currency';

  final double availableBalance;
  final String? currency;

  factory PaymobBudgetRM.fromJson(Map<String, dynamic> json) {
    return PaymobBudgetRM(
      availableBalance: double.tryParse(
            json[_availableBalanceKey]?.toString() ?? '0',
          ) ??
          0.0,
      currency: json[_currencyKey] as String?,
    );
  }
}
