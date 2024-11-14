import 'package:dio/dio.dart' as diox;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tymer_api/src/models/request/location_rm.dart';

part 'fulfill_other_service_rm.g.dart';

@JsonSerializable(createFactory: false)
class FulfillOtherServiceRM {
  const FulfillOtherServiceRM({
    required this.location,
    required this.details,
  });

  @JsonKey(name: 'location')
  final LocationRM location;
  @JsonKey(name: 'details')
  final FulfillOtherServiceDetailsRM details;

  Map<String, dynamic> toJson() => _$FulfillOtherServiceRMToJson(this);
}

@JsonSerializable(createFactory: false)
class FulfillOtherServiceDetailsRM {
  const FulfillOtherServiceDetailsRM({
    required this.date,
    required this.time,
    this.additionalNotes,
    this.image,
  });

  @JsonKey(name: 'date', includeIfNull: false)
  final String? date;
  @JsonKey(name: 'time', includeIfNull: false)
  final String? time;
  @JsonKey(name: 'other_details', includeIfNull: false)
  final String? additionalNotes;
  @JsonKey(name: 'attached_image', toJson: _uint8ToMultipart, includeIfNull: false)
  final Uint8List? image;

  static MultipartFile? _uint8ToMultipart(Uint8List? imageBytes) =>
      imageBytes == null
          ? null
          : diox.MultipartFile.fromBytes(
              imageBytes,
              filename:
                  'submit_service_image${DateTime.now().toString().split(" ").join("")}.jpg',
              // contentType: http.MediaType('image', 'jpg'),
            );

  Map<String, dynamic> toJson() => _$FulfillOtherServiceDetailsRMToJson(this);
}
