import 'package:domain_models/domain_models.dart';
import 'package:service_repository/src/mappers/domain_to_remote.dart';
import 'package:service_repository/src/service_change_notifier.dart';
import 'package:service_repository/src/service_local_storage.dart';
import 'package:tymer_api/tymer_api.dart';
import 'package:key_value_storage/key_value_storage.dart';

class ServiceRepository {
  ServiceRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  })  : changeNotifier = ServiceChangeNotifier(),
        _localStorage = ServiceLocalStorage(noSqlStorage: noSqlStorage);

  final TymerApi remoteApi;
  final ServiceLocalStorage _localStorage;
  final ServiceChangeNotifier changeNotifier;

  Future requestService({
    required ServiceType serviceType,
    required double price,
    String? locationType,
    required List<double> coordinates,
    required String placeName,
    required String placeAddress,
    required String reservedFor,
    required DateTime reservationDate,
    required ReservationServiceType reservationServiceType,
  }) async {
    final requestServiceRM = RequestService(
      serviceType: serviceType,
      price: price,
      location: RequestLocation(
        type: locationType,
        coordinates: coordinates,
      ),
      details: RequestDetails(
        placeName: placeName,
        placeAddress: placeAddress,
        reservedFor: reservedFor,
        reservationDate: reservationDate,
        reservationServiceCategoryId: reservationServiceType.id,
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
}
