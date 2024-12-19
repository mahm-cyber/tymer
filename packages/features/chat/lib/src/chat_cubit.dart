import 'dart:io';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_repository/service_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_repository/user_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.serviceRepository,
    required this.userRepository,
    required this.disputeId,
  })  : _imagePicker = ImagePicker(),
        super(const ChatState()) {
    init();
  }

  final scrollController = ScrollController();
  final ServiceRepository serviceRepository;
  final UserRepository userRepository;
  final ImagePicker _imagePicker;
  final TextEditingController messageController = TextEditingController();
  final int disputeId;

  Future init() async {
    await getChat();
    serviceRepository.initPusher().then((_) async {
      await Future.delayed(const Duration(seconds: 1));
      serviceRepository.listenToChat(disputeId);
    });
    final user = await userRepository.getUser().first;
    serviceRepository
        .chatStream(user!, disputeId)
        .listen((DisputeMessage message) {
      final lastDateGroupedMessages = state.dateGroupedMessages?.list.last;
      final lastDate = lastDateGroupedMessages?.date;
      final newDate = message.date;
      final isSameDay = lastDate?.year == newDate.year &&
          lastDate?.month == newDate.month &&
          lastDate?.day == newDate.day;
      final messageAlreadyExists = lastDateGroupedMessages?.messages.any(
        (element) => element.id == message.id,
      );
      if (messageAlreadyExists == true) return;

      if (isSameDay) {
        final lastGroupedMessagesUpdated = lastDateGroupedMessages?.copyWith(
          messages: [
            ...lastDateGroupedMessages.messages,
            message,
          ],
        );
        final groupedMessagesUpdated = state.dateGroupedMessages?.copyWith(
          list: [
            ...state.dateGroupedMessages!.list
              ..removeLast()
              ..add(lastGroupedMessagesUpdated!),
          ],
        );
        final updatedState = state.copyWith(
          dateGroupedMessages: groupedMessagesUpdated,
        );
        emit(const ChatState());
        emit(updatedState);
        jumpToBottomOfChat();
      }
    });
  }

  // get ticket_messages
  Future getChat() async {
    final loadingState =
        state.copyWith(fetchingStatus: ChatFetchingStatus.inProgress);
    emit(loadingState);
    final user = await userRepository.getUser().first;
    final userToken = await userRepository.getUserToken();
    try {
      final dateGroupedChats = await serviceRepository.getDateGroupedChat(
        disputeId,
        user!,
      );
      final successState = state.copyWith(
        fetchingStatus: ChatFetchingStatus.success,
        dateGroupedMessages: dateGroupedChats,
        userToken: userToken,
      );
      emit(successState);
      jumpToBottomOfChat();
    } catch (_) {
      final failureState = state.copyWith(
        fetchingStatus: ChatFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

  void jumpToBottomOfChat() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (scrollController.hasClients) {
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent,
        );
        await Future.delayed(const Duration(milliseconds: 100));
        if (scrollController.offset <
            scrollController.position.maxScrollExtent) {
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent,
          );
        }
      }
    });
  }

  Future pickFiles() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      final files =
          result.files.map((platformFile) => File(platformFile.path!)).toList();
      final newState = state.copyWith(
        files: [...?state.files, ...files],
      );
      emit(newState);
    } else {
      // User canceled the picker
    }
  }

  Future<void> pickImageFromGallery() async {
    XFile? xFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (xFile != null) {
      File? file = File(
        xFile.path.toString(),
      );
      final newState = state.copyWith(
        files: [...?state.files, file],
      );
      emit(newState);
    }
  }

  Future<void> capturePhoto() async {
    XFile? xFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (xFile != null) {
      File? file = File(
        xFile.path.toString(),
      );
      final newState = state.copyWith(
        files: [...?state.files, file],
      );
      emit(newState);
    }
  }

  void deletePickedFile() {
    final newState = ChatState(
      dateGroupedMessages: state.dateGroupedMessages,
      fetchingStatus: state.fetchingStatus,
      submissionStatus: state.submissionStatus,
      message: state.message,
      files: null,
      userToken: state.userToken,
    );
    emit(newState);
  }

  void onMessageChanged(String message) {
    final newState = state.copyWith(
      message: message,
    );
    emit(newState);
  }

  // Stream<DateGroupedChats> get chatStream => serviceRepository.chatStream();

  void openFileInExternalApp(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  // void downloadFile(FileDM file) async {
  //   try {
  //     folderRepository.downloadFiles([file.name]);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  void sendMessage() async {
    final newState = state.copyWith(
      submissionStatus: ChatSubmissionStatus.inProgress,
    );
    emit(newState);
    try {
      // await serviceRepository.sendChatMessage(
      //   messageId: state.messageBeingRepliedTo?.id,
      //   message: state.message,
      //   files: state.files,
      // );
      final newState = state.copyWith(
        submissionStatus: ChatSubmissionStatus.success,
      );
      emit(newState);
      final initialState = ChatState(
        dateGroupedMessages: state.dateGroupedMessages,
      );
      emit(initialState);
      messageController.clear();
      // getChat();
    } catch (e) {
      final failureState = state.copyWith(
        submissionStatus: ChatSubmissionStatus.failure,
      );
      emit(failureState);
      rethrow;
    }
  }

  @override
  Future<void> close() {
    // serviceRepository.stopListeningChat(disputeId);
    serviceRepository.disconnectPusher();
    return super.close();
  }
}
