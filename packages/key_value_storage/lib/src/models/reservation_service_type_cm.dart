import 'package:hive/hive.dart';

part 'reservation_service_type_cm.g.dart';

@HiveType(typeId: 2)
class ReservationServiceTypeCM {
  ReservationServiceTypeCM({
    required this.id,
    required this.name,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final NameCM name;
}

@HiveType(typeId: 3)
class NameCM {
  NameCM({
    required this.ar,
    required this.en,
  });

  @HiveField(0)
  final String ar;
  @HiveField(1)
  final String en;
}

@HiveType(typeId: 4)
class ReservationServiceTypesCM {
  ReservationServiceTypesCM({
    required this.list,
  });

  @HiveField(0)
  final List<ReservationServiceTypeCM> list;
}
