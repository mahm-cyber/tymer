import 'package:json_annotation/json_annotation.dart';
import 'package:tymer_api/src/models/request/location_rm.dart';
import 'package:tymer_api/tymer_api.dart';

part 'service_rm.g.dart';

@JsonSerializable(createToJson: false)
class ServiceRM {
  const ServiceRM({
    required this.id,
    required this.type,
    required this.details,
    required this.location,
    required this.distanceBetweenProviderAndServiceLocation,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'service_type')
  final String type;
  @JsonKey(name: 'service')
  final ServiceDetailsRM details;
  @JsonKey(name: 'service_location')
  final LocationRM location;
  @JsonKey(name: 'service_distance')
  final String distanceBetweenProviderAndServiceLocation;
  @JsonKey(name: 'service_total_price')
  final String totalPrice;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'created_at')
  final String createdAt;


  factory ServiceRM.fromJson(Map<String, dynamic> json) =>
      _$ServiceRMFromJson(json);
}


@JsonSerializable(createToJson: false)
class ServiceDetailsRM {
  const ServiceDetailsRM({
    required this.placeName,
    required this.placeAddress,
    this.date,
    this.additionalDetails,
  });

  @JsonKey(name: 'place_name')
  final String placeName;
  @JsonKey(name: 'place_address')
  final String placeAddress;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'other_details', includeIfNull: false)
  final String? additionalDetails;

  factory ServiceDetailsRM.fromJson(Map<String, dynamic> json) =>
      _$ServiceDetailsRMFromJson(json);
}
