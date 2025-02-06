
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class SupportChangeNotifier with ChangeNotifier {
  SupportChangeNotifier();

  /// This is set from [PusherAPI] whenever a new message is received and
  /// listened to in the [ChatScreen]
  final ValueNotifier<ChatMessage?> supportChatMessageVN = ValueNotifier(null);
  final ValueNotifier<bool> supportChatClosedVN = ValueNotifier(false);


  // SupportMessage? get chatMessage => _chatMessageVN.value;
  void setSupportChatMessage(ChatMessage? message) {
    supportChatMessageVN.value = message;
    notifyListeners();
  }

  Future clearSupportChatMessage() async {
    supportChatMessageVN.value = null;
    notifyListeners();
  }

  void setSupportChatClosed(bool supportChatClosed) {
    supportChatClosedVN.value = supportChatClosed;
    notifyListeners();
  }

  Future clearSupportChatClosed() async {
    supportChatClosedVN.value = false;
    notifyListeners();
  }
}
