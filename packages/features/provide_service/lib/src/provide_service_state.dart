part of 'provide_service_cubit.dart';

class ProvideServiceState extends Equatable {
  const ProvideServiceState({
    this.serviceType,
    this.reservationServiceTypes,
    this.selectedReservationServiceType =
        const Dynamic<ReservationServiceType?>.unvalidated(),
    this.reservationName = const Dynamic<String?>.unvalidated(),
    this.date = const Dynamic<DateTime?>.unvalidated(),
    this.placeName = const Dynamic<String?>.unvalidated(),
    this.address = const Dynamic<String?>.unvalidated(),
    this.location = const Dynamic<LatLng?>.unvalidated(),
    this.locationPickingInProgress = false,
    this.price = 20.0,
    this.additionalInfo = const Dynamic<String?>.unvalidated(),
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final ServiceType? serviceType;
  final List<ReservationServiceType>? reservationServiceTypes;
  final Dynamic<ReservationServiceType?> selectedReservationServiceType;
  final Dynamic<String?> reservationName;
  final Dynamic<DateTime?> date;
  final Dynamic<String?> placeName;
  final Dynamic<String?> address;
  final Dynamic<LatLng?> location;
  final bool locationPickingInProgress;
  final double price;
  final Dynamic<String?> additionalInfo;
  final FormzSubmissionStatus submissionStatus;

  ProvideServiceState copyWith({
    ServiceType? serviceType,
    List<ReservationServiceType>? reservationServiceTypes,
    Dynamic<ReservationServiceType?>? selectedReservationServiceType,
    Dynamic<String?>? reservationName,
    Dynamic<DateTime?>? date,
    Dynamic<String?>? placeName,
    Dynamic<String?>? address,
    Dynamic<LatLng?>? location,
    bool? locationPickingInProgress,
    double? price,
    Dynamic<String?>? additionalInfo,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return ProvideServiceState(
      serviceType: serviceType ?? this.serviceType,
      selectedReservationServiceType:
          selectedReservationServiceType ?? this.selectedReservationServiceType,
      reservationServiceTypes:
          reservationServiceTypes ?? this.reservationServiceTypes,
      reservationName: reservationName ?? this.reservationName,
      date: date ?? this.date,
      placeName: placeName ?? this.placeName,
      address: address ?? this.address,
      location: location ?? this.location,
      locationPickingInProgress:
          locationPickingInProgress ?? this.locationPickingInProgress,
      price: price ?? this.price,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
        serviceType,
        selectedReservationServiceType,
        reservationServiceTypes,
        reservationName,
        date,
        placeName,
        address,
        location,
        locationPickingInProgress,
        price,
        additionalInfo,
        submissionStatus,
      ];
}
