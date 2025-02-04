import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class DisputeChangeNotifier with ChangeNotifier {
  DisputeChangeNotifier();

  // This is set from the disputes screen because we need the userType
  // to get the correct dispute chat
  final ValueNotifier<UserType?> _disputeChatUserTypeVN = ValueNotifier(null);

  /// This is set from the [DisputesScreen] and from the pusher listener
  /// in [PusherAPI] to update the status of the chat if it is resolved
  final ValueNotifier<Dispute?> currentDisputeVN = ValueNotifier(null);

  /// This is set from [PusherAPI] whenever a new message is received and
  /// listened to in the [ChatScreen]
  final ValueNotifier<ChatMessage?> disputeChatMessageVN = ValueNotifier(null);

  /// This is set from the [ChatScreen] whenever we need to make the
  /// [DisputesScreen] refresh the disputes list
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
  Future setCurrentDispute(Dispute? dispute) async {
    currentDisputeVN.value = dispute;
    notifyListeners();
  }

  Future clearCurrentDispute() async {
    currentDisputeVN.value = null;
    notifyListeners();
  }

  // DisputeMessage? get chatMessage => _chatMessageVN.value;
  void setDisputeChatMessage(ChatMessage? message) {
    disputeChatMessageVN.value = message;
    notifyListeners();
  }

  Future clearDisputeChatMessage() async {
    disputeChatMessageVN.value = null;
    notifyListeners();
  }

  // bool? get shouldReFetchDisputes => _shouldReFetchDisputesVN.value;
  void setShouldReFetchDisputes(bool shouldReFetchDisputes) {
    shouldReFetchDisputesVN.value = shouldReFetchDisputes;
    notifyListeners();
    clearShouldReFetchDisputes();
  }

  Future clearShouldReFetchDisputes() async {
    shouldReFetchDisputesVN.value = null;
    notifyListeners();
  }
}
