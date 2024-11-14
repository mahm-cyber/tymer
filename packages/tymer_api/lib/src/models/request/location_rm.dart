import 'package:json_annotation/json_annotation.dart';

part 'location_rm.g.dart';


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

