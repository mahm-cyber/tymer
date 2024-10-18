import 'package:domain_models/domain_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_repository/src/mappers/domain_to_remote.dart';
import 'package:service_repository/src/mappers/mappers.dart';
import 'package:service_repository/src/service_change_notifier.dart';
import 'package:tymer_api/tymer_api.dart';
import 'package:key_value_storage/key_value_storage.dart';

class ServiceRepository {
  ServiceRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  }) : changeNotifier = ServiceChangeNotifier();

  final TymerApi remoteApi;
  final ServiceChangeNotifier changeNotifier;

  Future requestService({
    required ServiceType serviceType,
    required double price,
    String? locationType,
    required LatLng coordinates,
    required String placeName,
    required String placeAddress,
    String? reservedFor,
    required DateTime date,
    ReservationServiceType? reservationServiceType,
  }) async {
    final requestServiceRM = Service(
      type: serviceType,
      price: price,
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
        reservationServiceCategoryId: reservationServiceType?.id,
      ),
    ).toRemoteModel();
    try {
      await remoteApi.requestService(
        requestServiceRM: requestServiceRM,
      );
    } catch (error) {
      if (error is InsufficientBalanceTymerException) {
        throw InsufficientBalanceException();
      }
      rethrow;
    }
  }

  Future<List<Service>> getAllServiceRequests({
    required double lat,
    required double long,
    required String mode,
  }) async {
    try {
      final serviceRequests = await remoteApi.getAllServiceRequests(
        lat: lat,
        long: long,
        mode: mode,
      );
      return serviceRequests
          .map((serviceRequest) => serviceRequest.toDomainModel())
          .toList();
    } catch (error) {
      rethrow;
    }
  }
}
