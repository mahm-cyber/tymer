import 'package:json_annotation/json_annotation.dart';

part 'reservation_service_type_rm.g.dart';

@JsonSerializable(createToJson: false)
class ReservationServiceTypeRM {
  ReservationServiceTypeRM({
    required this.id,
    required this.name,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final NameRM name;

  static const fromJson = _$ReservationServiceTypeRMFromJson;
}

@JsonSerializable(createToJson: false)
class NameRM {
  NameRM({
    required this.ar,
    required this.en,
  });

  @JsonKey(name: 'ar')
  final String ar;
  @JsonKey(name: 'en')
  final String en;

  static const fromJson = _$NameFromJson;
}

@JsonSerializable(createToJson: false)
class ReservationServiceTypesRM {
  ReservationServiceTypesRM({
    required this.list,
  });

  @JsonKey(name: 'data')
  final List<ReservationServiceTypeRM> list;

  static const fromJson = _$ReservationServiceTypesRMFromJson;
}
