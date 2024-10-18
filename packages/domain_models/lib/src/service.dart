import 'package:domain_models/src/service_type.dart';

class Service {
  const Service({
    this.id,
    this.distanceBetweenProviderAndServiceLocation,
    this.status,
     this.createdAt,
    required this.type,
    required this.price,
    required this.location,
    required this.details,
  });

  final int? id;
  final double? distanceBetweenProviderAndServiceLocation;
  final ServiceStatus? status;
  final DateTime? createdAt;
  final ServiceType type;
  final double price;
  final LocationDM location;
  final ServiceDetails details;
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
    this.reservedFor,
    required this.date,
    this.reservationServiceCategoryId,
    this.additionalDetails,
  });

  final String placeName;
  final String placeAddress;
  final String? reservedFor;
  final DateTime date;
  final int? reservationServiceCategoryId;
  final String? additionalDetails;
}


enum ServiceStatus {
  pending,
  inProgress,
  completed,
  canceled,
  pendingReview,
  disputed,
}
