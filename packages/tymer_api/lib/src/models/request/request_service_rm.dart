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
  final LocationRM location;
  @JsonKey(name: 'details')
  final ServiceRequestDetailsRM details;

  Map<String, dynamic> toJson() => _$RequestServiceRMToJson(this);
}

@JsonSerializable()
class LocationRM {
  const LocationRM({
    this.type = 'Point',
    required this.coordinates,
  });

  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'coordinates')
  final List<double> coordinates;

  Map<String, dynamic> toJson() => _$LocationRMToJson(this);
  factory LocationRM.fromJson(Map<String, dynamic> json) =>
      _$LocationRMFromJson(json);
}

@JsonSerializable(createFactory: false)
class ServiceRequestDetailsRM {
  const ServiceRequestDetailsRM({
    required this.placeName,
    required this.placeAddress,
    this.reservedFor,
    this.reservationDate,
    this.detailsDate,
    this.reservationServiceCategoryId,
  });

  @JsonKey(name: 'place_name')
  final String placeName;
  @JsonKey(name: 'place_address')
  final String placeAddress;
  @JsonKey(name: 'reserved_for', includeIfNull: false)
  final String? reservedFor;
  @JsonKey(name: 'reservation_date', includeIfNull: false)
  final String? reservationDate;
  @JsonKey(name: 'date', includeIfNull: false)
  final String? detailsDate;
  @JsonKey(name: 'reservation_service_category_id', includeIfNull: false)
  final int? reservationServiceCategoryId;

  Map<String, dynamic> toJson() => _$ServiceRequestDetailsRMToJson(this);
}
