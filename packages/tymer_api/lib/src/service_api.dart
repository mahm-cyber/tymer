import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as diox;

import 'package:tymer_api/tymer_api.dart';

class ServiceApi {
  static const _errorJsonKey = 'error';
  static const _dataJsonKey = 'data';
  static const _verificationErrorsJsonKey = 'verification_errors';
  static const _codeJsonKey = 'code';
  static const _validationErrorJsonKey = 'VALIDATION_ERROR';

  final Dio _dio;
  final UrlBuilder _urlBuilder;

  ServiceApi(
    this._dio,
    this._urlBuilder,
  );

  Future<ReservationServiceTypesRM> getReservationServiceTypes() async {
    final url = _urlBuilder.buildGetReservationServiceTypesUrl();
    try {
      final response = await _dio.get(url);
      final reservationServiceTypes =
          ReservationServiceTypesRM.fromJson(response.data);
      return reservationServiceTypes;
    } catch (_) {
      rethrow;
    }
  }

  Future<int> requestService({
    required RequestServiceRM requestServiceRM,
  }) async {
    final url = _urlBuilder.buildRequestServiceUrl();
    final requestJsonBody = requestServiceRM.toJson();
    try {
      final response = await _dio.post(url, data: requestJsonBody);
      final requestId = response.data[_dataJsonKey]['id'] as int;
      return requestId;
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey];
      final errorCode = errorObject[_codeJsonKey];
      if (errorCode.contains('INSUFFICIENT_BALANCE')) {
        throw InsufficientBalanceTymerException();
      }
      if (errorCode.contains(_validationErrorJsonKey) &&
          errorObject[_verificationErrorsJsonKey].containsKey('price')) {
        throw StaleMinimumPriceTymerException();
      }
      rethrow;
    }
  }

  Future<ServiceListPageRM> getAllServiceRequests({
    int? page,
    required double lat,
    required double long,
    required String userType,
    String? status,
    bool sortByCreatedAt = false,
  }) async {
    final url = _urlBuilder.buildGetAllServiceRequestsUrl(
      page: page,
      lat: lat,
      long: long,
      userType: userType,
      status: status,
      sortByCreatedAt: sortByCreatedAt,
    );
    try {
      final response = await _dio.get(url);
      final serviceRequests = ServiceListPageRM.fromJson(response.data);
      final hasPagination = response.data['meta'] != null;
      if (hasPagination) {
        final currentPage = response.data['meta']['current_page'] as int;
        final lastPage = response.data['meta']['last_page'] as int;
        final isLastPage = currentPage >= lastPage;
        serviceRequests.isLastPage = isLastPage;
      }
      return serviceRequests;
    } catch (_) {
      rethrow;
    }
  }

  Future acceptServiceRequest({required int serviceRequestId}) async {
    final url = _urlBuilder.buildAcceptServiceRequestUrl(
        serviceRequestId: serviceRequestId);
    try {
      await _dio.post(url);
    } on DioException catch (error) {
      final errorObject = error.response?.data[_errorJsonKey][_codeJsonKey];
      if (errorObject.contains('SERVICE_REQUEST_ALREADY_PROCESSED')) {
        throw ServiceRequestAlreadyProcessedTymerException();
      }
      rethrow;
    }
  }

  Future fulfillServiceRequest({
    required int serviceRequestId,
    FulfillOtherServiceRM? fulfillOtherServiceRM,
    FulfillReservationServiceRM? fulfillReservationServiceRM,
  }) async {
    assert(fulfillOtherServiceRM != null || fulfillReservationServiceRM != null,
        'fulfillOtherServiceRM or fulfillReservationServiceRM must not be null');
    final url = _urlBuilder.buildSubmitServiceRequestUrl(
        serviceRequestId: serviceRequestId);
    final requestJsonBody = fulfillOtherServiceRM != null
        ? fulfillOtherServiceRM.toJson()
        : fulfillReservationServiceRM!.toJson();

    final formData = diox.FormData.fromMap(
      {
        'location': (requestJsonBody['location'] as LocationRM).toJson(),
        'details': fulfillOtherServiceRM != null
            ? (requestJsonBody['details'] as FulfillOtherServiceDetailsRM)
                .toJson()
            : (requestJsonBody['details'] as FulfillReservationServiceDetailsRM)
                .toJson(),
      },
      ListFormat.multiCompatible,
    );

    try {
      await _dio.post(url, data: formData);
    } catch (_) {
      rethrow;
    }
  }

  Future<ServiceRM> getServiceRequest({required int requestId}) async {
    final url =
        _urlBuilder.buildGetServiceRequestUrl(serviceRequestId: requestId);
    try {
      final response = await _dio.get(url);
      final serviceRequest = ServiceRM.fromJson(response.data[_dataJsonKey]);
      return serviceRequest;
    } catch (_) {
      rethrow;
    }
  }

  Future confirmServiceRequest({required int serviceRequestId}) async {
    final url = _urlBuilder.buildConfirmServiceRequestUrl(
        serviceRequestId: serviceRequestId);
    try {
      await _dio.post(url);
    } catch (_) {
      rethrow;
    }
  }

  Future cancelServiceRequest(
      {required int serviceRequestId,
      Map<String, String>? queryParameters}) async {
    final url = _urlBuilder.buildCancelServiceRequestUrl(
      serviceRequestId: serviceRequestId,
    );
    try {
      await _dio.post(
        url,
      );
    } catch (_) {
      rethrow;
    }
  }
}
