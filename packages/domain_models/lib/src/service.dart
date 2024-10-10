import 'package:domain_models/src/service_type.dart';

class Service {
  const Service({
    required this.type,
    required this.price,
    required this.location,
    required this.details,
  });

  final ServiceType type;
  final double price;
  final Location location;
  final ServiceDetails details;
}

class Location {
  const Location({
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
    required this.reservedFor,
    required this.reservationDate,
    required this.reservationServiceCategoryId,
  });

  final String placeName;
  final String placeAddress;
  final String reservedFor;
  final DateTime reservationDate;
  final int reservationServiceCategoryId;
}
