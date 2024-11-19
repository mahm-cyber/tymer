import 'package:json_annotation/json_annotation.dart';

part 'reservation_service_response_rm.g.dart';

@JsonSerializable(createToJson: false)
class ReservationServiceRM {
  const ReservationServiceRM({
    required this.date,
    required this.code,
    required this.time,
    this.additionalNotes,
    this.image,
  });

  @JsonKey(name: 'reservation_date')
  final String date;
  @JsonKey(name: 'reservation_code')
  final String code;
  @JsonKey(name: 'reservation_time')
  final String time;
  @JsonKey(name: 'other_details', includeIfNull: false)
  final String? additionalNotes;
  @JsonKey(name: 'attached_image_url', includeIfNull: false)
  final String? image;

  factory ReservationServiceRM.fromJson(Map<String, dynamic> json) =>
      _$ReservationServiceRMFromJson(json);
}

