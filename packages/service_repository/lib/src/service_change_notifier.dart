import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ServiceChangeNotifier with ChangeNotifier, EquatableMixin {
  ServiceChangeNotifier();

  final ValueNotifier<ServiceType?> _serviceType = ValueNotifier(null);
  final ValueNotifier<Service?> _serviceRequestDetails = ValueNotifier(null);
  final ValueNotifier<UserType?> _disputeChatUserType = ValueNotifier(null);
  final ValueNotifier<Dispute?> currentDispute = ValueNotifier(null);
  BehaviorSubject<DisputeMessage> chatSubject  = BehaviorSubject<DisputeMessage>();


  dynamic get serviceType => _serviceType.value;
  void setServiceType(ServiceType serviceType) {
    _serviceType.value = serviceType;
    notifyListeners();
  }
  Future clearServiceType() async {
    _serviceType.value = null;
    notifyListeners();
  }

  Service? get serviceRequestDetails => _serviceRequestDetails.value;
  void setServiceRequest(Service serviceRequestDetails) {
    _serviceRequestDetails.value = serviceRequestDetails;
    notifyListeners();
  }
  Future clearServiceRequest() async {
    _serviceRequestDetails.value = null;
    notifyListeners();
  }

  UserType? get disputeChatUserType => _disputeChatUserType.value;
  void setDisputeChatUserType(UserType userType) {
    _disputeChatUserType.value = userType;
    notifyListeners();
  }
  Future clearDisputeChatUserType() async {
    _disputeChatUserType.value = null;
    notifyListeners();
  }

  Future setCurrentDispute(Dispute? dispute) async{
    currentDispute.value = dispute;
    notifyListeners();
  }
  Future clearCurrentDisputeType() async {
    currentDispute.value = null;
    notifyListeners();
  }



  @override
  List<Object?> get props => [
        currentDispute,
        _serviceType,
        _serviceRequestDetails,
        _disputeChatUserType,
      ];
}
