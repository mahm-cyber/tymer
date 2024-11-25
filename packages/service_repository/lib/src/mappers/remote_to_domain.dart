import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:tymer_api/tymer_api.dart';

extension ServiceRMtoDM on ServiceRM {
  ServiceType serviceTypeRMtoDM(String serviceType) {
    switch (serviceType) {
      case 'other_service':
        return ServiceType.other;
      case 'reservation_service':
        return ServiceType.reservation;
      default:
        throw Exception('Unknown service type');
    }
  }

  Service toDomainModel() {
    try {
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

      final isOtherService = serviceTypeRMtoDM(type) == ServiceType.other;

      ServiceResponse? serviceResponse;
      if (isOtherService) {
        serviceResponse = response != null
            ? (response as OtherServiceRM).toDomainModel()
            : null;
      } else {
        serviceResponse = response != null
            ? (response as ReservationServiceRM).toDomainModel()
            : null;
      }
      return Service(
        id: id,
        distanceBetweenProviderAndServiceLocation:
            double.tryParse(distanceBetweenProviderAndServiceLocation ?? ''),
        status: serviceStatusRMtoDM(status),
        createdAt: DateTime.parse(createdAt),
        type: serviceTypeRMtoDM(type),
        price: double.parse(totalPrice),
        location: location.toDomainModel(),
        details: details?.toDomainModel(),
        response: serviceResponse,
      );
    } catch (e) {
      throw Exception('Error parsing ServiceRM to ServiceDM: $e');
    }
  }
}

extension OtherServiceResponseRMtoDM on OtherServiceRM {
  ServiceResponse toDomainModel() {
    return ServiceResponse(
      date: date != null ? DateTime.parse(date!) : null,
      time: time != null ? stringToTimeOfDay(time!) : null,
      additionalNotes: additionalNotes,
      imageUrl: image == null ? null : '${UrlBuilder.baseUrl}/files/${image!}',
    );
  }
}

extension ReservationServiceResponseRMtoDM on ReservationServiceRM {
  ServiceResponse toDomainModel() {
    return ServiceResponse(
      reservationNumber: code,
      time: stringToTimeOfDay(time),
      date: DateTime.parse(date),
      additionalNotes: additionalNotes,
      imageUrl: image == null ? null : '${UrlBuilder.baseUrl}/files/${image!}',
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
      date: date != null ? DateTime.parse(date!) : null,
      additionalComments: additionalDetails,
    );
  }
}

TimeOfDay stringToTimeOfDay(String timeString) {
  final parts = timeString.split(':');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}
