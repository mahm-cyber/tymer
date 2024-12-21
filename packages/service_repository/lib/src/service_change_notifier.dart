import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ServiceChangeNotifier with ChangeNotifier, EquatableMixin {
  ServiceChangeNotifier();

  final ValueNotifier<ServiceType?> _serviceTypeVN = ValueNotifier(null);
  final ValueNotifier<Service?> _serviceRequestDetailsVN = ValueNotifier(null);
  final ValueNotifier<UserType?> _disputeChatUserTypeVN = ValueNotifier(null);
  final ValueNotifier<Dispute?> _currentDisputeVN = ValueNotifier(null);
  final ValueNotifier<DisputeMessage?> _chatMessageVN  = ValueNotifier(null);
  final ValueNotifier<bool?> _shouldReFetchDisputesVN = ValueNotifier(null);

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

  UserType? get disputeChatUserType => _disputeChatUserTypeVN.value;
  void setDisputeChatUserType(UserType userType) {
    _disputeChatUserTypeVN.value = userType;
    notifyListeners();
  }
  Future clearDisputeChatUserType() async {
    _disputeChatUserTypeVN.value = null;
    notifyListeners();
  }

  Dispute? get currentDispute => _currentDisputeVN.value;
  Future setCurrentDispute(Dispute? dispute) async{
    _currentDisputeVN.value = dispute;
    notifyListeners();
  }
  Future clearCurrentDispute() async {
    _currentDisputeVN.value = null;
    notifyListeners();
  }

  DisputeMessage? get chatMessage => _chatMessageVN.value;
  void setChatMessage(DisputeMessage? message) {
    _chatMessageVN.value = message;
    notifyListeners();
  }
  Future clearChatMessage() async {
    _chatMessageVN.value = null;
    notifyListeners();
  }

  bool? get shouldReFetchDisputes => _shouldReFetchDisputesVN.value;
  void setShouldReFetchDisputes(bool shouldReFetchDisputes) {
    _shouldReFetchDisputesVN.value = shouldReFetchDisputes;
    notifyListeners();
  }
  Future clearShouldReFetchDisputes() async {
    _shouldReFetchDisputesVN.value = null;
    notifyListeners();
  }



  @override
  List<Object?> get props => [
        currentDispute,
        _serviceTypeVN,
        _serviceRequestDetailsVN,
        _disputeChatUserTypeVN,
      ];
}
