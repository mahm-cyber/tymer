import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ServiceChangeNotifier with ChangeNotifier, EquatableMixin {
  ServiceChangeNotifier();

  final ValueNotifier<ServiceType?> _serviceType = ValueNotifier(null);
  final ValueNotifier<Service?> _serviceRequestDetails = ValueNotifier(null);


  dynamic get serviceType => _serviceType.value;
  void setServiceType(ServiceType serviceType) {
    _serviceType.value = serviceType;
    notifyListeners();
  }
  Future clearServiceType() async {
    _serviceType.value = null;
    notifyListeners();
  }
  
  dynamic get serviceRequestDetails => _serviceRequestDetails.value;
  void setServiceRequest(Service serviceRequestDetails) {
    _serviceRequestDetails.value = serviceRequestDetails;
    notifyListeners();
  }
  Future clearServiceRequest() async {
    _serviceRequestDetails.value = null;
    notifyListeners();
  }



  @override
  List<Object?> get props => [
        _serviceType,
        _serviceRequestDetails,
      ];
}
