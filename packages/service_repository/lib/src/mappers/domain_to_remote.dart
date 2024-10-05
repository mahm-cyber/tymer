import 'package:domain_models/domain_models.dart';
import 'package:tymer_api/tymer_api.dart';

extension RequestServiceDMtoRM on RequestService {
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
    final reservationDateRM = '${details.reservationDate.year}'
        '-${details.reservationDate.month}'
        '-${details.reservationDate.day}';
    final serviceTypeRM = serviceTypeDMtoRM(serviceType);
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
        reservationDate: reservationDateRM,
        reservationServiceCategoryId: details.reservationServiceCategoryId,
      ),
    );
  }
}
