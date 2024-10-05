import 'package:domain_models/src/service_type.dart';

class Service {
  const Service({
    required this.serviceType,
    required this.price,
    required this.location,
    required this.details,
  });

  final ServiceType serviceType;
  final double price;
  final RequestLocation location;
  final RequestDetails details;
}

class RequestLocation {
  const RequestLocation({
    this.type = 'Point',
    required this.coordinates,
  });

  final String? type;
  final List<double> coordinates;
}

class RequestDetails {
  const RequestDetails({
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
