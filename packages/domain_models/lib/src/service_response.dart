import 'package:flutter/material.dart';

class ServiceResponse {
  const ServiceResponse({
    this.reservationNumber,
    this.date,
    this.time,
    this.additionalNotes,
    this.imageUrl,
  });

  final String? reservationNumber;
  final DateTime? date;
  final TimeOfDay? time;
  final String? additionalNotes;
  final String? imageUrl;
}
