import 'package:json_annotation/json_annotation.dart';
import 'package:tymer_api/src/models/request/location_rm.dart';

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


@JsonSerializable(createFactory: false)
class ServiceRequestDetailsRM {
  const ServiceRequestDetailsRM({
    required this.placeName,
    required this.placeAddress,
    this.reservedFor,
    this.reservationDate,
    this.detailsDate,
    this.reservationServiceCategoryId,
    this.additionalComments,
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
  @JsonKey(name: 'other_details', includeIfNull: false)
  final String? additionalComments;

  Map<String, dynamic> toJson() => _$ServiceRequestDetailsRMToJson(this);
}
