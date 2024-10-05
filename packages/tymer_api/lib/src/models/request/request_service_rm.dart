import 'package:json_annotation/json_annotation.dart';

part 'request_service_rm.g.dart';

@JsonSerializable(createFactory: false)
class RequestServiceRM {
  const RequestServiceRM({
    required this.type,
    required this.price,
    required this.location,
    required this.details,
  });

  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'price')
  final double price;
  @JsonKey(name: 'location')
  final RequestLocationRM location;
  @JsonKey(name: 'details')
  final RequestDetailsRM details;

  Map<String, dynamic> toJson() => _$RequestServiceRmToJson(this);
}

@JsonSerializable(createFactory: false)
class RequestLocationRM {
  const RequestLocationRM({
    this.type = 'Point',
    required this.coordinates,
  });

  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'coordinates')
  final List<double> coordinates;

  Map<String, dynamic> toJson() => _$RequestLocationRMToJson(this);
}

@JsonSerializable(createFactory: false)
class RequestDetailsRM {
  const RequestDetailsRM({
    required this.placeName,
    required this.placeAddress,
    required this.reservedFor,
    required this.reservationDate,
    required this.reservationServiceCategoryId,
  });

  @JsonKey(name: 'place_name')
  final String placeName;
  @JsonKey(name: 'place_address')
  final String placeAddress;
  @JsonKey(name: 'reserved_for')
  final String reservedFor;
  @JsonKey(name: 'reservation_date')
  final String reservationDate;
  @JsonKey(name: 'reservation_service_category_id')
  final int reservationServiceCategoryId;

  Map<String, dynamic> toJson() => _$RequestDetailsRMToJson(this);
}
