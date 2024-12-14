import 'package:json_annotation/json_annotation.dart';
import 'package:tymer_api/tymer_api.dart';

part 'service_rm.g.dart';

@JsonSerializable(createToJson: false)
class ServiceRM {
  const ServiceRM({
    required this.id,
    required this.type,
    this.details,
    required this.location,
    this.distanceBetweenProviderAndServiceLocation,
    required this.totalPrice,
    required this.servicePrice,
    required this.servicefee,
    required this.status,
    required this.createdAt,
    this.response,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'service_type')
  final String type;
  @JsonKey(name: 'service')
  final ServiceDetailsRM? details;
  @JsonKey(name: 'service_location')
  final LocationRM location;
  @JsonKey(name: 'service_distance')
  final String? distanceBetweenProviderAndServiceLocation;
  @JsonKey(name: 'service_total_price')
  final String totalPrice;
  @JsonKey(name: 'service_price')
  final String servicePrice;
  @JsonKey(name: 'service_fee')
  final String servicefee;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(
    name: 'service_response',
    fromJson: _responseFromJson,
    includeIfNull: true,
  )
  final dynamic response;

  factory ServiceRM.fromJson(Map<String, dynamic> json) =>
      _$ServiceRMFromJson(json);

  static dynamic _responseFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    // check if json has a key called reservation_date
    final isReservationService = json.containsKey('reservation_date');
    final isOtherService = json.containsKey('date');
    if (isReservationService) {
      return ReservationServiceRM.fromJson(json);
    } else if (isOtherService) {
      return OtherServiceRM.fromJson(json);
    }
  }
}

@JsonSerializable(createToJson: false)
class ServiceDetailsRM {
  const ServiceDetailsRM({
    required this.placeName,
    required this.placeAddress,
    this.date,
    this.time,
    this.reservedFor,
    this.reservationDate,
    this.reservationTime,
    this.reservationServiceCategory,
    this.additionalDetails,
  });

  @JsonKey(name: 'place_name')
  final String placeName;
  @JsonKey(name: 'place_address')
  final String placeAddress;
  @JsonKey(name: 'date', includeIfNull: false)
  final String? date;
  @JsonKey(name: 'time', includeIfNull: false)
  final String? time;
  @JsonKey(name: 'reserved_for', includeIfNull: false)
  final String? reservedFor;
  @JsonKey(name: 'reservation_date', includeIfNull: false)
  final String? reservationDate;
  @JsonKey(name: 'reservation_time', includeIfNull: false)
  final String? reservationTime;
  @JsonKey(name: 'reservation_service_category', includeIfNull: false)
  final ReservationServiceTypeRM? reservationServiceCategory;
  @JsonKey(name: 'other_details', includeIfNull: false)
  final String? additionalDetails;

  factory ServiceDetailsRM.fromJson(Map<String, dynamic> json) =>
      _$ServiceDetailsRMFromJson(json);
}

@JsonSerializable(createToJson: false)
class ServiceListPageRM {
  ServiceListPageRM({
    required this.list,
    this.isLastPage,
  });

  @JsonKey(name: 'data')
  final List<ServiceRM> list;
  @JsonKey(includeFromJson: false)
  bool? isLastPage;

  static const fromJson = _$ServiceListPageRMFromJson;
}
