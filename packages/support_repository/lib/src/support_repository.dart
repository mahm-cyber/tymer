import 'dart:async';
import 'dart:io';

import 'package:dispute_repository/dispute_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:support_repository/src/support_change_notifier.dart';
import 'package:tymer_api/tymer_api.dart';

class SupportRepository {
  SupportRepository({
    required this.remoteApi,
  }) : changeNotifier = SupportChangeNotifier();

  final TymerApi remoteApi;
  final SupportChangeNotifier changeNotifier;

  late StreamSubscription<ChatMessageRM?> _supportChatSubscription;
  late StreamSubscription<String?> _supportChatStatusSubscription;

  // region Pusher Operations
  Future initPusher() async {
    remoteApi.pusher.initPusher();
  }

  Future disconnectPusher() async {
    remoteApi.pusher.disconnectPusher();
  }

  Future listenToSupportChat(int supportChatId) async {
    try {
      remoteApi.pusher.listenToRemoteSupportChatStatus(chatId: supportChatId);
      await Future.delayed(const Duration(seconds: 1));
      remoteApi.pusher.listenToRemoteSupportChat(chatId: supportChatId);
    } catch (error) {
      debugPrint('Error listening to requester chat: $error');
      rethrow;
    }
  }

  Future stopListeningSupportChat(int chatId) async {
    try {
      remoteApi.pusher.stopListeningToRemoteSupportChat(chatId: chatId);
      remoteApi.pusher.stopListeningToSupportChatStatus(chatId: chatId);

      remoteApi.pusher.supportChatMessageSC.add(null);
      remoteApi.pusher.supportChatStatusSC.add(null);
      _supportChatSubscription.cancel();
      _supportChatStatusSubscription.cancel();
    } catch (error) {
      debugPrint('Error stopping listening to requester chat: $error');
      rethrow;
    }
  }
  // endregion

  // region Support Chat Operations
  Future<int?> checkIfUserHasSupportChat() async {
    return await remoteApi.supportChat.checkIfUserHasSupportChat();
  }

  Future<int> createSupportChat() async {
    return await remoteApi.supportChat.createSupportChat();
  }

  Future<DateGroupedMessagesList> getDateGroupedSupportChat(
    int supportChatId,
    User user,
  ) async {
    final supportChatRM =
        await remoteApi.supportChat.getSupportChat(supportChatId: supportChatId);
    final dateGroupedChats = supportChatRM.toDomainModel(supportChatId);

    return dateGroupedChats.copyWith(
      list: dateGroupedChats.list
          .map((chat) => _mapChatWithUserMessages(chat, user))
          .toList(),
    );
  }

  DateGroupedMessages _mapChatWithUserMessages(
    DateGroupedMessages chat,
    User user,
  ) {
    return chat.copyWith(
      messages: chat.messages
          .map((message) => _markUserMessages(message, user))
          .toList(),
    );
  }

  ChatMessage _markUserMessages(ChatMessage message, User user) {
    return message.copyWith(
      isSentByMe: message.sender.id == user.id,
    );
  }
  // endregion

  // region Message Handling
  Future sendSupportChatMessage({
    required int supportChatId,
    String? message,
    List<FileDM>? files,
  }) async {
    try {
      final hasFiles = files?.isNotEmpty == true;

      await remoteApi.supportChat.sendSupportChatMessage(
        supportChatId: supportChatId,
        message: message,
        imageFiles: hasFiles ? getFilesOfType(files!, FileType.image) : null,
        documentFiles:
            hasFiles ? getFilesOfType(files!, FileType.document) : null,
        audioFiles: hasFiles ? getFilesOfType(files!, FileType.audio) : null,
      );
    } catch (error) {
      if (error is ChatLimitReachedTymerException) {
        throw ChatLimitReachedException();
      }
      rethrow;
    }
  }

  List<File?>? getFilesOfType(List<FileDM> files, FileType type) {
    final filtered = files
        .where((file) => file.type == type)
        .map((fileDM) => fileDM.file)
        .toList();

    return filtered.isEmpty ? null : filtered;
  }
  // endregion

  // region Stream Initialization
  void initializeSupportChatStream(
    User user,
    int supportChatId,
  ) {
    _supportChatSubscription =
        remoteApi.pusher.supportChatMessageSC.listen((event) async {
      if (event == null) return;
      final domainMessage = event.toDomainModel(supportChatId);
      final isSentByMe = domainMessage.sender.id == user.id;
      final updatedMessage = domainMessage.copyWith(
        isSentByMe: isSentByMe,
      );
      await Future.delayed(const Duration(milliseconds: 100));
      changeNotifier.setSupportChatMessage(updatedMessage);
    });
  }

  void initializeSupportChatStatusStream() {
    _supportChatStatusSubscription =
        remoteApi.pusher.supportChatStatusSC.listen((event) {
      if (event == null) return;
      changeNotifier.setSupportChatClosed(event == 'closed');
    });
  }
  // endregion
}
