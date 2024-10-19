import 'package:domain_models/domain_models.dart';
import 'package:tymer_api/tymer_api.dart';

extension ServiceRMtoDM on ServiceRM {
  ServiceType serviceTypeRMtoDM(String serviceType) {
    switch (serviceType) {
      case 'other_service':
        return ServiceType.other;
      case 'reservation':
        return ServiceType.reservation;
      default:
        throw Exception('Unknown service type');
    }
  }

  Service toDomainModel() {
    ServiceStatus serviceStatusRMtoDM(String status) {
      switch (status) {
        case 'pending':
          return ServiceStatus.pending;
        case 'in-progress':
          return ServiceStatus.inProgress;
        case 'completed':
          return ServiceStatus.completed;
        case 'canceled':
          return ServiceStatus.canceled;
        case 'pending-review':
          return ServiceStatus.pendingReview;
        case 'disputed':
          return ServiceStatus.disputed;
        default:
          throw Exception('Unknown service status');
      }
    }

    return Service(
      id: id,
      distanceBetweenProviderAndServiceLocation:
          double.parse(distanceBetweenProviderAndServiceLocation),
      status: serviceStatusRMtoDM(status),
      createdAt: DateTime.parse(createdAt),
      type: serviceTypeRMtoDM(type),
      price: double.parse(totalPrice),
      location: location.toDomainModel(),
      details: details.toDomainModel(),
    );
  }
}

extension LocationRMtoDM on LocationRM {
  LocationDM toDomainModel() {
    return LocationDM(
      type: type,
      coordinates: coordinates,
    );
  }
}

extension ServiceDetailsRMtoDM on ServiceDetailsRM {
  ServiceDetails toDomainModel() {
    return ServiceDetails(
      placeName: placeName,
      placeAddress: placeAddress,
      date: DateTime.parse(date),
      additionalComments: additionalDetails,
    );
  }
}
