import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DisputeChangeNotifier with ChangeNotifier, EquatableMixin {
  DisputeChangeNotifier();


  final ValueNotifier<UserType?> _disputeChatUserTypeVN = ValueNotifier(null);
  final ValueNotifier<Dispute?> currentDisputeVN = ValueNotifier(null);
  final ValueNotifier<DisputeMessage?> chatMessageVN  = ValueNotifier(null);
  final ValueNotifier<bool?> shouldReFetchDisputesVN = ValueNotifier(null);


  UserType? get disputeChatUserType => _disputeChatUserTypeVN.value;
  void setDisputeChatUserType(UserType userType) {
    _disputeChatUserTypeVN.value = userType;
    notifyListeners();
  }
  Future clearDisputeChatUserType() async {
    _disputeChatUserTypeVN.value = null;
    notifyListeners();
  }

  // Dispute? get currentDispute => _currentDisputeVN.value;
  Future setCurrentDispute(Dispute? dispute) async{
    currentDisputeVN.value = dispute;
    notifyListeners();
  }
  Future clearCurrentDispute() async {
    currentDisputeVN.value = null;
    notifyListeners();
  }

  // DisputeMessage? get chatMessage => _chatMessageVN.value;
  void setChatMessage(DisputeMessage? message) {
    chatMessageVN.value = message;
    notifyListeners();
  }
  Future clearChatMessage() async {
    chatMessageVN.value = null;
    notifyListeners();
  }

  // bool? get shouldReFetchDisputes => _shouldReFetchDisputesVN.value;
  void setShouldReFetchDisputes(bool shouldReFetchDisputes) {
    shouldReFetchDisputesVN.value = shouldReFetchDisputes;
    notifyListeners();
  }
  Future clearShouldReFetchDisputes() async {
    shouldReFetchDisputesVN.value = null;
    notifyListeners();
  }



  @override
  List<Object?> get props => [
    _disputeChatUserTypeVN,
        currentDisputeVN,
        chatMessageVN,
        shouldReFetchDisputesVN,
      ];
}
