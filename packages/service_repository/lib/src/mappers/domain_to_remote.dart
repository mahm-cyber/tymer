import 'package:domain_models/domain_models.dart';
import 'package:tymer_api/tymer_api.dart';

extension RequestServiceDMtoRM on Service {
  String serviceTypeDMtoRM(ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.reservation:
        return 'reservation_service';
      case ServiceType.other:
        return 'other_service';
    }
  }

  RequestServiceRM toRemoteModel() {
    //2024-10-14 in this format
    final dateRM = '${details.date.year}'
        '-${details.date.month}'
        '-${details.date.day}';
    final serviceTypeRM = serviceTypeDMtoRM(type);
    return RequestServiceRM(
      type: serviceTypeRM,
      price: price,
      location: RequestLocationRM(
        type: location.type,
        coordinates: location.coordinates,
      ),
      details: RequestDetailsRM(
        placeName: details.placeName,
        placeAddress: details.placeAddress,
        reservedFor: details.reservedFor,
        reservationDate: type == ServiceType.reservation ? dateRM : null,
        detailsDate: type == ServiceType.other ? dateRM : null,
        reservationServiceCategoryId: type == ServiceType.reservation
            ? details.reservationServiceCategoryId
            : null,
      ),
    );
  }
}
