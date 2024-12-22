import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class ServiceChangeNotifier with ChangeNotifier {
  ServiceChangeNotifier();

  final ValueNotifier<ServiceType?> _serviceTypeVN = ValueNotifier(null);
  final ValueNotifier<Service?> _serviceRequestDetailsVN = ValueNotifier(null);

  dynamic get serviceType => _serviceTypeVN.value;

  void setServiceType(ServiceType serviceType) {
    _serviceTypeVN.value = serviceType;
    notifyListeners();
  }

  Future clearServiceType() async {
    _serviceTypeVN.value = null;
    notifyListeners();
  }

  Service? get serviceRequestDetails => _serviceRequestDetailsVN.value;

  void setServiceRequest(Service serviceRequestDetails) {
    _serviceRequestDetailsVN.value = serviceRequestDetails;
    notifyListeners();
  }

  Future clearServiceRequest() async {
    _serviceRequestDetailsVN.value = null;
    notifyListeners();
  }

}
