import 'dart:io';

import 'package:domain_models/domain_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:service_repository/src/mappers/domain_to_remote.dart';
import 'package:service_repository/src/mappers/mappers.dart';
import 'package:service_repository/src/service_change_notifier.dart';
import 'package:tymer_api/tymer_api.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceRepository {
  ServiceRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  }) : changeNotifier = ServiceChangeNotifier();

  final TymerApi remoteApi;
  final ServiceChangeNotifier changeNotifier;

  Future<int> requestService({
    required ServiceType serviceType,
    required double price,
    String? locationType,
    required LatLng coordinates,
    required String placeName,
    required String placeAddress,
    String? reservedFor,
    String? additionalComments,
    required DateTime date,
    TimeOfDay? time,
    ReservationServiceType? reservationServiceType,
  }) async {
    final requestServiceRM = Service(
      type: serviceType,
      totalPrice: price,
      location: LocationDM(
        type: 'Point',
        coordinates: [
          coordinates.latitude,
          coordinates.longitude,
        ],
      ),
      details: ServiceDetails(
        placeName: placeName,
        placeAddress: placeAddress,
        reservedFor: reservedFor,
        date: date,
        time: time,
        reservationServiceCategory: reservationServiceType,
        additionalComments: additionalComments,
      ),
    ).toRemoteModel();
    try {
      final requestId = await remoteApi.requestService(
        requestServiceRM: requestServiceRM,
      );
      return requestId;
    } catch (error) {
      if (error is InsufficientBalanceTymerException) {
        throw InsufficientBalanceException();
      }
      rethrow;
    }
  }

  Future<ServiceListPage> getAllServiceRequests({
    int? page,
    required double lat,
    required double long,
    required UserType userType,
    ServiceStatus? status,
  }) async {
    try {
      final serviceRequests = await remoteApi.getAllServiceRequests(
        page: page,
        lat: lat,
        long: long,
        userType: userType.toRemoteModel(),
        status: status?.toRemoteModel(),
      );
      final serviceRequestsDomainModel = serviceRequests.toDomainModel();
      return serviceRequestsDomainModel;
    } catch (error) {
      rethrow;
    }
  }

  Future<Service> getServiceRequest({
    required int requestId,
  }) async {
    try {
      final serviceRequestDetails =
          await remoteApi.getServiceRequest(requestId: requestId);
      return serviceRequestDetails.toDomainModel();
    } catch (error) {
      rethrow;
    }
  }

  Future acceptServiceRequest({
    required int serviceRequestId,
  }) async {
    try {
      await remoteApi.acceptServiceRequest(
        serviceRequestId: serviceRequestId,
      );
    } catch (error) {
      //ServiceRequestAlreadyProcessedTymerException
      if (error is ServiceRequestAlreadyProcessedTymerException) {
        throw ServiceRequestAlreadyProcessed();
      }
      rethrow;
    }
  }

  Future fulfillServiceRequest({
    required Service serviceRequestDetails,
    required String? reservationNumber,
    required DateTime? day,
    required TimeOfDay? time,
    required String? additionalDetails,
    required Uint8List? imageBytes,
  }) async {
    final isReservationService =
        serviceRequestDetails.type == ServiceType.reservation;
    final isOtherService = serviceRequestDetails.type == ServiceType.other;
    final fulfillServiceRequestRM = FulfillServiceRequest(
      serviceType: serviceRequestDetails.type,
      location: serviceRequestDetails.location,
      details: FulfillServiceRequestDetails(
        reservationNumber: reservationNumber,
        date: day,
        time: time,
        additionalNotes: additionalDetails,
        imageBytes: imageBytes,
      ),
    ).toRemoteModel();
    try {
      await remoteApi.fulfillServiceRequest(
        serviceRequestId: serviceRequestDetails.id!,
        fulfillOtherServiceRM: isOtherService
            ? fulfillServiceRequestRM as FulfillOtherServiceRM
            : null,
        fulfillReservationServiceRM: isReservationService
            ? fulfillServiceRequestRM as FulfillReservationServiceRM
            : null,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future confirmServiceRequest({
    required int serviceRequestId,
  }) async {
    try {
      await remoteApi.confirmServiceRequest(
        serviceRequestId: serviceRequestId,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future cancelServiceRequest({
    required int serviceRequestId,
  }) async {
    try {
      await remoteApi.cancelServiceRequest(
        serviceRequestId: serviceRequestId,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<LocationData?> getUserLocation() async {
    try {
      Location location = Location();

      bool serviceEnabled;
      PermissionStatus permissionGranted;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return null;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }
      // await Future.delayed(const Duration(milliseconds: 300));
      final locationData = await location.getLocation();
      return locationData;
    } catch (error) {
      rethrow;
    }
  }

  void launchMapOnAndroid(double latitude, double longitude) async {
    try {
      const String markerLabel = 'Here';
      final url = Uri.parse(
          'geo:$latitude,$longitude?q=$latitude,$longitude($markerLabel)');
      await launchUrl(url);
    } catch (error) {
      rethrow;
    }
  }

  void launchMapOnIOS(double latitude, double longitude) async {
    try {
      final url = Uri.parse('maps:$latitude,$longitude?q=$latitude,$longitude');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (error) {
      rethrow;
    }
  }

  void launchMap(
    double latitude,
    double longitude,
  ) async {
    if (Platform.isAndroid) {
      launchMapOnAndroid(latitude, longitude);
    } else if (Platform.isIOS) {
      launchMapOnIOS(latitude, longitude);
    }
  }

  Future disputeRequest({
    required int serviceRequestId,
    required String reason,
  }) async {
    try {
      await remoteApi.disputeRequest(
        serviceRequestId: serviceRequestId,
        reason: reason,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<DisputeListPage> getDisputes({
    required int page,
    required UserType userType,
    DisputeStatus? disputeStatus,
  }) async {
    try {
      final disputes = await remoteApi.getAllDisputes(
        page: page,
        userType: userType.toRemoteModel(),
        status: disputeStatus?.toRemoteModel(),
      );
      final disputesDomainModel = disputes.toDomainModel();
      return disputesDomainModel;
    } catch (error) {
      rethrow;
    }
  }
}
