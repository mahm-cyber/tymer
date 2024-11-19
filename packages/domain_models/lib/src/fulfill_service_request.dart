import 'package:domain_models/domain_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FulfillServiceRequest {
  const FulfillServiceRequest({
    required this.serviceType,
    required this.location,
    required this.details,
  });
  final ServiceType serviceType;
  final LocationDM location;
  final FulfillServiceRequestDetails details;
}

class FulfillServiceRequestDetails {
  const FulfillServiceRequestDetails({
    this.reservationNumber,
    this.date,
    this.time,
    this.additionalNotes,
    this.imageBytes,
  });

  final String? reservationNumber;
  final DateTime? date;
  final TimeOfDay? time;
  final String? additionalNotes;
  final Uint8List? imageBytes;
}
