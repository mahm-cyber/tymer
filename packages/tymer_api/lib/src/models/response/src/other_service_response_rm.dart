import 'package:json_annotation/json_annotation.dart';

part 'other_service_response_rm.g.dart';

@JsonSerializable(createToJson: false)
class OtherServiceRM {
  const OtherServiceRM({
     this.date,
     this.time,
    this.additionalNotes,
    this.image,

  });

  @JsonKey(name: 'date', includeIfNull: false)
  final String? date;
  @JsonKey(name: 'time', includeIfNull: false)
  final String? time;
  @JsonKey(name: 'other_details', includeIfNull: false)
  final String? additionalNotes;
  @JsonKey(name: 'attached_image_url', includeIfNull: false)
  final String? image;

  factory OtherServiceRM.fromJson(Map<String, dynamic> json) =>
      _$OtherServiceRMFromJson(json);
}
