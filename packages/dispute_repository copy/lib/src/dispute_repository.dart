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
  late StreamSubscription<ChatMessageRM?> _disputeChatSubscription;
  late StreamSubscription<String?> _remoteDisputeResolutionSubscription;

  Future<Dispute> getDispute(
    int disputeId,
  ) async {
    try {
      final disputeRM = await remoteApi.getDispute(
        disputeId: disputeId,
        userType: changeNotifier.disputeChatUserType!.toRemoteModel(),
      );
      final dispute = disputeRM.toDomainModel();
      changeNotifier.setCurrentDispute(dispute);
      return dispute;
    } catch (error) {
      rethrow;
    }
  }

  Future<int> disputeRequest({
    required int serviceRequestId,
    required String reason,
  }) async {
    try {
      final disputeId = await remoteApi.disputeRequest(
        serviceRequestId: serviceRequestId,
        reason: reason,
      );
      return disputeId;
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

  Future<DateGroupedMessagesList> getDateGroupedDisputeChat(
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

  Future listenToDisputeChat(int disputeId) async {
    final userType = changeNotifier.disputeChatUserType!;
    try {
      remoteApi.pusherApi.listenToDisputeChatResolved(
        disputeId: disputeId,
        userType: userType.name,
      );
      await Future.delayed(const Duration(seconds: 1));
      remoteApi.pusherApi.listenToRemoteDisputeChat(
        disputeId: disputeId,
        userType: userType.name,
      );
    } catch (error) {
      debugPrint('Error listening to requester chat: $error');
      rethrow;
    }
  }

  Future stopListeningDisputeChat(int disputeId) async {
    final userType = changeNotifier.disputeChatUserType!;

    try {
      remoteApi.pusherApi.stopListeningToRemoteDisputeChat(
        disputeId: disputeId,
        userType: userType.name,
      );
      remoteApi.pusherApi.stopListeningToDisputeChatResolved(
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

  void initializeDisputeChatStream(User user, disputeId) {
    _disputeChatSubscription =
        remoteApi.pusherApi.disputeChatMessageSC.listen((ChatMessageRM? event) {
      if (event == null) return;
      final disputeMessage = event.toDomainModel(disputeId);
      final isSentByMe = disputeMessage.sender.id == user.id;
      final updatedDisputeMessage = disputeMessage.copyWith(
        isSentByMe: isSentByMe,
      );
      changeNotifier.setDisputeChatMessage(updatedDisputeMessage);
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

  Future sendDisputeChatMessage({
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
      await remoteApi.sendDisputeChatMessage(
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
