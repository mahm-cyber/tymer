import 'package:hive/hive.dart';

part 'pricing_settings_cm.g.dart';

@HiveType(typeId: 5)
class PricingSettingsCM {
  PricingSettingsCM({
    required this.reservationServiceMinPrice,
    required this.reservationServiceFee,
    required this.reservationServiceFeeType,
    required this.otherServiceMinPrice,
    required this.otherServiceFee,
    required this.otherServiceFeeType,
  });

  @HiveField(0)
  final int reservationServiceMinPrice;
  @HiveField(1)
  final int reservationServiceFee;
  @HiveField(2)
  final String reservationServiceFeeType;
  @HiveField(3)
  final int otherServiceMinPrice;
  @HiveField(4)
  final int otherServiceFee;
  @HiveField(5)
  final String otherServiceFeeType;
}
