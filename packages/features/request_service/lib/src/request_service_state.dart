part of 'request_service_cubit.dart';

class RequestServiceState extends Equatable {
  const RequestServiceState({
    this.requestId,
    this.serviceType,
    this.reservationServiceTypes,
    this.fetchingReservationServiceTypesStatus =
        FetchingReservationServiceTypesStatus.initial,
    this.selectedReservationServiceType =
        const Dynamic<ReservationServiceType?>.unvalidated(),
    this.reservationName = const Dynamic<String?>.unvalidated(),
    this.date = const Dynamic<DateTime?>.unvalidated(),
    this.time = const Dynamic<TimeOfDay?>.unvalidated(),
    this.placeName = const Dynamic<String?>.unvalidated(),
    this.address = const Dynamic<String?>.unvalidated(),
    this.location = const Dynamic<LatLng?>.unvalidated(),
    this.locationPickingInProgress = false,
    this.locationServiceStatus,
    this.price,
    this.pricingSettings,
    this.fetchingPricingSettingsStatus = FetchingPricingSettingsStatus.initial,
    this.additionalComments = const Dynamic<String?>.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.error,
  });

  final int? requestId;
  final ServiceType? serviceType;
  final List<ReservationServiceType>? reservationServiceTypes;
  final FetchingReservationServiceTypesStatus fetchingReservationServiceTypesStatus;
  final Dynamic<ReservationServiceType?> selectedReservationServiceType;
  final Dynamic<String?> reservationName;
  final Dynamic<DateTime?> date;
  final Dynamic<TimeOfDay?> time;
  final Dynamic<String?> placeName;
  final Dynamic<String?> address;

  final Dynamic<LatLng?> location;
  final bool locationPickingInProgress;
  final geo.ServiceStatus? locationServiceStatus;
  final double? price;
  final PricingSettings? pricingSettings;
  final FetchingPricingSettingsStatus fetchingPricingSettingsStatus;
  final Dynamic<String?> additionalComments;
  final FormzSubmissionStatus submissionStatus;
  final dynamic error;

  RequestServiceState copyWith({
    int? requestId,
    ServiceType? serviceType,
    List<ReservationServiceType>? reservationServiceTypes,
    FetchingReservationServiceTypesStatus? fetchingReservationServiceTypesStatus,
    Dynamic<ReservationServiceType?>? selectedReservationServiceType,
    Dynamic<String?>? reservationName,
    Dynamic<DateTime?>? date,
    Dynamic<TimeOfDay?>? time,
    Dynamic<String?>? placeName,
    Dynamic<String?>? address,
    Dynamic<LatLng?>? location,
    bool? locationPickingInProgress,
    geo.ServiceStatus? locationServiceStatus,
    double? price,
    PricingSettings? pricingSettings,
    FetchingPricingSettingsStatus? fetchingPricingSettingsStatus,
    Dynamic<String?>? additionalComments,
    FormzSubmissionStatus? submissionStatus,
    dynamic error,
  }) {
    return RequestServiceState(
      requestId: requestId ?? this.requestId,
      serviceType: serviceType ?? this.serviceType,
      selectedReservationServiceType:
          selectedReservationServiceType ?? this.selectedReservationServiceType,
      reservationServiceTypes:
          reservationServiceTypes ?? this.reservationServiceTypes,
      fetchingReservationServiceTypesStatus: fetchingReservationServiceTypesStatus ?? this.fetchingReservationServiceTypesStatus,
      reservationName: reservationName ?? this.reservationName,
      date: date ?? this.date,
      time: time ?? this.time,
      placeName: placeName ?? this.placeName,
      address: address ?? this.address,
      location: location ?? this.location,
      locationPickingInProgress:
          locationPickingInProgress ?? this.locationPickingInProgress,
      locationServiceStatus:
          locationServiceStatus ?? this.locationServiceStatus,
      price: price ?? this.price,
      pricingSettings: pricingSettings ?? this.pricingSettings,
      fetchingPricingSettingsStatus:
          fetchingPricingSettingsStatus ?? this.fetchingPricingSettingsStatus,
      additionalComments: additionalComments ?? this.additionalComments,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        requestId,
        serviceType,
        selectedReservationServiceType,
        reservationServiceTypes,
        fetchingReservationServiceTypesStatus,
        reservationName,
        date,
        time,
        placeName,
        address,
        location,
        locationPickingInProgress,
        locationServiceStatus,
        price,
        pricingSettings,
        fetchingPricingSettingsStatus,
        additionalComments,
        submissionStatus,
        error
      ];
}

enum FetchingPricingSettingsStatus {
  initial,
  inProgress,
  success,
  failure,
}

enum FetchingReservationServiceTypesStatus {
  initial,
  inProgress,
  success,
  failure,
}