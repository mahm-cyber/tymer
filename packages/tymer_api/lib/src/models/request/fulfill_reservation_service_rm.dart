import 'package:dio/dio.dart' as diox;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tymer_api/src/models/request/location_rm.dart';

part 'fulfill_reservation_service_rm.g.dart';

@JsonSerializable(createFactory: false)
class FulfillReservationServiceRM {
  const FulfillReservationServiceRM({
    required this.location,
    required this.details,
  });

  @JsonKey(name: 'location')
  final LocationRM location;
  @JsonKey(name: 'details')
  final FulfillReservationServiceDetailsRM details;

  Map<String, dynamic> toJson() => _$FulfillReservationServiceRMToJson(this);
}

@JsonSerializable(createFactory: false)
class FulfillReservationServiceDetailsRM {
  const FulfillReservationServiceDetailsRM({
    required this.day,
    required this.code,
    required this.time,
    this.additionalNotes,
    this.image,
  });

  @JsonKey(name: 'reservation_date')
  final String day;
  @JsonKey(name: 'reservation_code')
  final String code;
  @JsonKey(name: 'reservation_time')
  final String time;
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

  Map<String, dynamic> toJson() =>
      _$FulfillReservationServiceDetailsRMToJson(this);
}
