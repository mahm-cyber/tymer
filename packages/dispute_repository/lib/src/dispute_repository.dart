import 'dart:async';
import 'dart:io';

import 'package:dispute_repository/src/dispute_change_notifier.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dispute_repository/src/mappers/domain_to_remote.dart';
import 'package:dispute_repository/src/mappers/mappers.dart';
import 'package:tymer_api/tymer_api.dart';
import 'package:key_value_storage/key_value_storage.dart';

class DisputeRepository {
  DisputeRepository({
    required KeyValueStorage noSqlStorage,
    required this.remoteApi,
  }) : changeNotifier = DisputeChangeNotifier();

  final TymerApi remoteApi;
  final DisputeChangeNotifier changeNotifier;
  late StreamSubscription<DisputeMessageRM?> _disputeChatSubscription;
  late StreamSubscription<String?> _remoteDisputeResolutionSubscription;




  Future disputeRequest({
    required int serviceRequestId,
    required String reason,
  }) async {
    try {
      await remoteApi.disputeRequest(
        serviceRequestId: serviceRequestId,
        reason: reason,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<DisputeListPage> getDisputes({
    required int page,
    required UserType userType,
    DisputeStatus? disputeStatus,
  }) async {
    try {
      final disputes = await remoteApi.getAllDisputes(
        page: page,
        userType: userType.toRemoteModel(),
        status: disputeStatus?.toRemoteModel(),
      );
      final disputesDomainModel = disputes.toDomainModel();
      return disputesDomainModel;
    } catch (error) {
      rethrow;
    }
  }

  Future<DateGroupedMessagesList> getDateGroupedChat(
    int disputeId,
    User user,
  ) async {
    try {
      final disputeChatRM = await remoteApi.getDisputeChat(
        disputeId: disputeId,
        userType: changeNotifier.disputeChatUserType!.toRemoteModel(),
      );
      final dateGroupedChats = disputeChatRM.toDomainModel(disputeId);
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

  Future initPusher() async {
    try {
      remoteApi.pusherApi.initPusher();
    } catch (error) {
      debugPrint('Error initializing pusher: $error');
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

  Future listenToChat(int disputeId) async {
    final userType = changeNotifier.disputeChatUserType!;
    try {
      remoteApi.pusherApi.listenToChatResolved(
        disputeId: disputeId,
        userType: userType.name,
      );
      await Future.delayed(const Duration(seconds: 1));
      remoteApi.pusherApi.listenToRemoteChat(
        disputeId: disputeId,
        userType: userType.name,
      );

    } catch (error) {
      debugPrint('Error listening to requester chat: $error');
      rethrow;
    }
  }

  Future stopListeningChat(int disputeId) async {
    final userType = changeNotifier.disputeChatUserType!;

    try {
      remoteApi.pusherApi.stopListeningToRemoteChat(
        disputeId: disputeId,
        userType: userType.name,
      );
      remoteApi.pusherApi.stopListeningToChatResolved(
        disputeId: disputeId,
        userType: userType.name,
      );

      remoteApi.pusherApi.disputeChatMessageSC.add(null);
      _disputeChatSubscription.cancel();
      remoteApi.pusherApi.disputeStatusSC.add(null);
      _remoteDisputeResolutionSubscription.cancel();
    } catch (error) {
      debugPrint('Error stopping listening to requester chat: $error');
      rethrow;
    }
  }

  void initializeChatStream(User user, disputeId) {
    _disputeChatSubscription = remoteApi.pusherApi.disputeChatMessageSC
        .listen((DisputeMessageRM? event) {
      if (event == null) return;
      final disputeMessage = event.toDomainModel(disputeId);
      final isSentByMe = disputeMessage.sender.id == user.id;
      final updatedDisputeMessage = disputeMessage.copyWith(
        isSentByMe: isSentByMe,
      );
      changeNotifier.setChatMessage(updatedDisputeMessage);
    });
  }

  void initializeDisputeResolutionStream() {
    _remoteDisputeResolutionSubscription =
        remoteApi.pusherApi.disputeStatusSC.listen(
      (String? event) {
        if (event == null) return;
        final currentDispute = changeNotifier.currentDisputeVN.value;
        final newStatus = disputeStatusRMtoDM(event);
        final dispute = currentDispute!.copyWith(status: newStatus);
        changeNotifier.setCurrentDispute(dispute);
      },
    );
  }

  Future sendChatMessage({
    required int disputeId,
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
      await remoteApi.sendChatMessage(
        userType: changeNotifier.disputeChatUserType!.toRemoteModel(),
        disputeId: disputeId,
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
