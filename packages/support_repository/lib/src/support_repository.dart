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

  Future<DateGroupedMessagesList> getDateGroupedSupportChat(
    int supportChatId,
    User user,
  ) async {
    try {
      final supportChatRM = await remoteApi.getSupportChat(
        supportChatId: supportChatId,
      );
      final dateGroupedChats = supportChatRM.toDomainModel(supportChatId);
      final dateGroupedChatsDM = dateGroupedChats.copyWith(
        list: dateGroupedChats.list
            .map(
              (chat) => chat.copyWith(
                messages: chat.messages.map(
                  (message) {
                    final isSentByMe = message.sender.id == user.id;
                    return message.copyWith(
                      isSentByMe: isSentByMe,
                    );
                  },
                ).toList(),
              ),
            )
            .toList(),
      );
      return dateGroupedChatsDM;
    } catch (error) {
      rethrow;
    }
  }

  Future<int?> checkIfUserHasSupportChat() async {
    try {
      final chatId = await remoteApi.checkIfUserHasSupportChat();
      return chatId;
    } catch (error) {
      rethrow;
    }
  }

  Future<int> createSupportChat() async {
    try {
      final supportChatId = await remoteApi.createSupportChat();
      return supportChatId;
    } catch (error) {
      rethrow;
    }
  }

  Future initPusher() async {
    try {
      remoteApi.pusherApi.initPusher();
    } catch (error) {
      rethrow;
    }
  }

  Future disconnectPusher() async {
    try {
      remoteApi.pusherApi.disconnectPusher();
    } catch (error) {
      rethrow;
    }
  }

  Future listenToSupportChat(int supportChatId) async {
    try {
      remoteApi.pusherApi.listenToRemoteSupportChat(
        chatId: supportChatId,
      );
    } catch (error) {
      debugPrint('Error listening to requester chat: $error');
      rethrow;
    }
  }

  Future stopListeningSupportChat(int chatId) async {
    try {
      remoteApi.pusherApi.stopListeningToRemoteSupportChat(
        chatId: chatId,
      );

      _supportChatSubscription.cancel();
    } catch (error) {
      debugPrint('Error stopping listening to requester chat: $error');
      rethrow;
    }
  }

  void initializeSupportChatStream(
    User user,
    int supportChatId,
  ) {
    _supportChatSubscription = remoteApi.pusherApi.supportChatMessageSC.listen(
      (ChatMessageRM? event) {
        if (event == null) return;
        final supportChatRM = event.toDomainModel(supportChatId);
        final isSentByMe = supportChatRM.sender.id == user.id;
        final updatedSupportMessage = supportChatRM.copyWith(
          isSentByMe: isSentByMe,
        );
        changeNotifier.setSupportChatMessage(updatedSupportMessage);
      },
    );
  }

  Future sendSupportChatMessage({
    required int supportChatId,
    String? message,
    List<FileDM>? files,
  }) async {
    List<File?>? imageFiles;
    List<File?>? documentFiles;
    List<File?>? audioFiles;
    final hasFiles = files?.isNotEmpty == true;

    if (hasFiles) {
      imageFiles = getFilesOfType(files!, FileType.image);
      documentFiles = getFilesOfType(files, FileType.document);
      audioFiles = getFilesOfType(files, FileType.audio);
    }

    try {
      await remoteApi.sendSupportChatMessage(
        supportChatId: supportChatId,
        message: message,
        imageFiles: imageFiles,
        documentFiles: documentFiles,
        audioFiles: audioFiles,
      );
    } catch (error) {
      rethrow;
    }
  }

  List<File?>? getFilesOfType(List<FileDM> files, FileType type) {
    final filesOfType = files
        .where((file) => file.type == type)
        .map((fileDM) => fileDM.file)
        .toList();
    if (filesOfType.isEmpty) {
      return null;
    }
    return filesOfType;
  }
}
