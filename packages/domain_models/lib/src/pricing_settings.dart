
class PricingSettings {
  PricingSettings({
    required this.reservationServiceMinPrice,
    required this.reservationServiceFee,
    required this.reservationServiceFeeType,
    required this.otherServiceMinPrice,
    required this.otherServiceFee,
    required this.otherServiceFeeType,
  });

  final int reservationServiceMinPrice;
  final int reservationServiceFee;
  final String reservationServiceFeeType;
  final int otherServiceMinPrice;
  final int otherServiceFee;
  final String otherServiceFeeType;
}
