import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class Service {
  const Service({
    this.id,
    this.distanceBetweenProviderAndServiceLocation,
    this.status,
    this.createdAt,
    required this.type,
    required this.totalPrice,
    this.price,
    this.fee,
    required this.location,
    this.details,
    this.response,
  });

  final int? id;
  final double? distanceBetweenProviderAndServiceLocation;
  final ServiceStatus? status;
  final DateTime? createdAt;
  final ServiceType type;
  final double totalPrice;
  final double? price;
  final double? fee;
  final LocationDM location;
  final ServiceDetails? details;
  final ServiceResponse? response;
}

class LocationDM {
  const LocationDM({
    this.type = 'Point',
    required this.coordinates,
  });

  final String? type;
  final List<double> coordinates;
}

class ServiceDetails {
  const ServiceDetails({
    required this.placeName,
    required this.placeAddress,
    this.date,
    this.time,
    this.reservedFor,
    this.reservationDate,
    this.reservationTime,
    this.reservationServiceCategory,
    this.additionalComments,
  });

  final String placeName;
  final String placeAddress;
  final DateTime? date;
  final TimeOfDay? time;
  final String? reservedFor;
  final DateTime? reservationDate;
  final TimeOfDay? reservationTime;
  final ReservationServiceType? reservationServiceCategory;
  final String? additionalComments;
}

enum ServiceStatus {
  pending,
  inProgress,
  completed,
  canceled,
  pendingReview,
  disputed;

  Color get color {
    switch (this) {
      case ServiceStatus.pending:
        return const Color(0xFF2D9CDB);
      case ServiceStatus.inProgress:
        return const Color(0xFF27AE60);
      case ServiceStatus.completed:
        return const Color(0xFF2C8268);
      case ServiceStatus.canceled:
        return const Color(0xFFEB5757);
      case ServiceStatus.pendingReview:
        return Colors.orange;
      case ServiceStatus.disputed:
        return const Color(0xFFEB5757);
    }
  }
}

class ServiceListPage {
  const ServiceListPage({
    required this.list,
    this.isLastPage,
  });

  final List<Service> list;
  final bool? isLastPage;
}
