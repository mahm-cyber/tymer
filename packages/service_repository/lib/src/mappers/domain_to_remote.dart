import 'package:domain_models/domain_models.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';
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
    final dateRM = details!.date?.formattedDate;
    final serviceTypeRM = serviceTypeDMtoRM(type);
    return RequestServiceRM(
      type: serviceTypeRM,
      price: price,
      location: LocationRM(
        type: location.type,
        coordinates: location.coordinates,
      ),
      details: ServiceRequestDetailsRM(
        placeName: details!.placeName,
        placeAddress: details!.placeAddress,
        reservedFor: details!.reservedFor,
        reservationDate: type == ServiceType.reservation ? dateRM : null,
        detailsDate: type == ServiceType.other ? dateRM : null,
        reservationServiceCategoryId: type == ServiceType.reservation
            ? details!.reservationServiceCategory!.id
            : null,
      ),
    );
  }
}
// ServiceStatus serviceStatusRMtoDM(String status) {
//   switch (status) {
//     case 'pending':
//       return ServiceStatus.pending;
//     case 'in-progress':
//       return ServiceStatus.inProgress;
//     case 'completed':
//       return ServiceStatus.completed;
//     case 'canceled':
//       return ServiceStatus.canceled;
//     case 'pending-review':
//       return ServiceStatus.pendingReview;
//     case 'disputed':
//       return ServiceStatus.disputed;
//     default:
//       throw Exception('Unknown service status');
//   }
// }

extension ServiceStatusDMtoRM on ServiceStatus {
  String toRemoteModel() {
    switch (this) {
      case ServiceStatus.pending:
        return 'pending';
      case ServiceStatus.inProgress:
        return 'in-progress';
      case ServiceStatus.completed:
        return 'completed';
      case ServiceStatus.canceled:
        return 'canceled';
      case ServiceStatus.pendingReview:
        return 'pending-review';
      case ServiceStatus.disputed:
        return 'disputed';
    }
  }
}

extension FulfillServiceRequestDMtoRM on FulfillServiceRequest {
  dynamic toRemoteModel() {
    if (serviceType == ServiceType.reservation) {
      return FulfillReservationServiceRM(
        location: LocationRM(
          type: location.type,
          coordinates: location.coordinates,
        ),
        details: FulfillReservationServiceDetailsRM(
          code: details.reservationNumber!,
          day: details.date!.formattedDate,
          additionalNotes: details.additionalNotes,
          time: details.time!.twentyFourHrFormat,
          image: details.imageBytes,
        ),
      );
    }
    if (serviceType == ServiceType.other) {
      return FulfillOtherServiceRM(
        location: LocationRM(
          type: location.type,
          coordinates: location.coordinates,
        ),
        details: FulfillOtherServiceDetailsRM(
          date: details.date?.formattedDate,
          additionalNotes: details.additionalNotes,
          time: details.time?.twentyFourHrFormat,
          image: details.imageBytes,
        ),
      );
    }
  }
}

extension ServiceRequestsFetchModeDMtoRM on UserType {
  String toRemoteModel() {
    switch (this) {
      case UserType.requester:
        return 'requester';
      case UserType.provider:
        return 'provider';
    }
  }
}

extension DisputeStatusDMtoRM on DisputeStatus {
  String toRemoteModel() {
    switch (this) {
      case DisputeStatus.pendingReview:
        return 'pending-review';
      case DisputeStatus.chargedBack:
        return 'charged-back';
      case DisputeStatus.denied:
        return 'denied';
    }
  }
}