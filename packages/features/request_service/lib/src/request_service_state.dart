part of 'request_service_cubit.dart';

class RequestServiceState extends Equatable {
  const RequestServiceState({
    this.requestId,
    this.serviceType,
    this.reservationServiceTypes,
    this.selectedReservationServiceType =
        const Dynamic<ReservationServiceType?>.unvalidated(),
    this.reservationName = const Dynamic<String?>.unvalidated(),
    this.date = const Dynamic<DateTime?>.unvalidated(),
    this.time = const Dynamic<TimeOfDay?>.unvalidated(),
    this.placeName = const Dynamic<String?>.unvalidated(),
    this.address = const Dynamic<String?>.unvalidated(),
    this.location = const Dynamic<LatLng?>.unvalidated(),
    this.locationPickingInProgress = false,
    this.price,
    this.pricingSettings,
    this.additionalComments = const Dynamic<String?>.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.error,
  });

  final int? requestId;
  final ServiceType? serviceType;
  final List<ReservationServiceType>? reservationServiceTypes;
  final Dynamic<ReservationServiceType?> selectedReservationServiceType;
  final Dynamic<String?> reservationName;
  final Dynamic<DateTime?> date;
  final Dynamic<TimeOfDay?> time;
  final Dynamic<String?> placeName;
  final Dynamic<String?> address;

  final Dynamic<LatLng?> location;
  final bool locationPickingInProgress;
  final double? price;
  final PricingSettings? pricingSettings;
  final Dynamic<String?> additionalComments;
  final FormzSubmissionStatus submissionStatus;
  final dynamic error;

  RequestServiceState copyWith({
    int? requestId,
    ServiceType? serviceType,
    List<ReservationServiceType>? reservationServiceTypes,
    Dynamic<ReservationServiceType?>? selectedReservationServiceType,
    Dynamic<String?>? reservationName,
    Dynamic<DateTime?>? date,
    Dynamic<TimeOfDay?>? time,
    Dynamic<String?>? placeName,
    Dynamic<String?>? address,
    Dynamic<LatLng?>? location,
    bool? locationPickingInProgress,
    double? price,
    PricingSettings? pricingSettings,
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
      reservationName: reservationName ?? this.reservationName,
      date: date ?? this.date,
      time: time ?? this.time,
      placeName: placeName ?? this.placeName,
      address: address ?? this.address,
      location: location ?? this.location,
      locationPickingInProgress:
          locationPickingInProgress ?? this.locationPickingInProgress,
      price: price ?? this.price,
      pricingSettings: pricingSettings ?? this.pricingSettings,
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
        reservationName,
        date,
        time,
        placeName,
        address,
        location,
        locationPickingInProgress,
        price,
        pricingSettings,
        additionalComments,
        submissionStatus,
        error
      ];
}
