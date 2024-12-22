import 'dart:async';
import 'dart:io';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart' as fp;
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
        super(
          ChatState(
            dispute: serviceRepository.changeNotifier.currentDisputeVN.value,
          ),
        ) {
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
    serviceRepository.initializeChatStream(user!, disputeId);
    serviceRepository.changeNotifier.chatMessageVN
        .addListener(_chatSubjectCallBack);

    serviceRepository.initializeDisputeResolutionStream();
    serviceRepository.changeNotifier.currentDisputeVN
        .addListener(_currentDisputeCallBack);


  }

  void _chatSubjectCallBack() {
    final chatMessage = serviceRepository.changeNotifier.chatMessageVN.value;
    if (chatMessage == null) return;
    final isFirstMessage = state.dateGroupedMessages == null ||
        state.dateGroupedMessages?.list.isEmpty == true;
    if (isFirstMessage) {
      final newGroupedMessages = DateGroupedMessages(
        date: chatMessage.date,
        messages: [chatMessage],
      );
      final groupedMessagesUpdated = DateGroupedMessagesList(
        list: [newGroupedMessages],
      );
      final updatedState = state.copyWith(
        dateGroupedMessages: groupedMessagesUpdated,
      );
      emit(const ChatState());
      emit(updatedState);
      jumpToBottomOfChat();
      return;
    }

    final lastDateGroupedMessages = state.dateGroupedMessages?.list.last;
    final lastDate = lastDateGroupedMessages?.date;
    final newDate = chatMessage.date;
    final isSameDay = lastDate?.year == newDate.year &&
        lastDate?.month == newDate.month &&
        lastDate?.day == newDate.day;
    final messageAlreadyExists = lastDateGroupedMessages?.messages.any(
      (element) => element.id == chatMessage.id,
    );
    if (messageAlreadyExists == true) return;

    if (isSameDay) {
      final lastGroupedMessagesUpdated = lastDateGroupedMessages?.copyWith(
        messages: [
          ...lastDateGroupedMessages.messages,
          chatMessage,
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
      if (!isClosed) {
        emit(const ChatState());
        emit(updatedState);
        jumpToBottomOfChat();
      }
    } else {
      final newGroupedMessages = DateGroupedMessages(
        date: newDate,
        messages: [chatMessage],
      );
      final groupedMessagesUpdated = state.dateGroupedMessages?.copyWith(
        list: [
          ...state.dateGroupedMessages!.list,
          newGroupedMessages,
        ],
      );
      final updatedState = state.copyWith(
        dateGroupedMessages: groupedMessagesUpdated,
      );
      emit(const ChatState());
      emit(updatedState);
      jumpToBottomOfChat();
      return;
    }
  }

  void _currentDisputeCallBack() {
    final dispute = serviceRepository.changeNotifier.currentDisputeVN.value;
    final newState = state.copyWith(
      dispute: dispute,
    );
    if (!isClosed) emit(newState);
    serviceRepository.changeNotifier.setShouldReFetchDisputes(true);
    serviceRepository.changeNotifier.clearShouldReFetchDisputes();
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

  Future pickFile() async {
    final fp.FilePickerResult? result = await fp.FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: fp.FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'ppt',
        'pptx',
      ],
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
      dispute: state.dispute,
    );
    emit(newState);
  }

  void onMessageChanged(String message) {
    final newState = state.copyWith(
      message: message,
    );
    emit(newState);
  }

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

  void sendMessage() async {
    final newState = state.copyWith(
      submissionStatus: ChatSubmissionStatus.inProgress,
    );
    emit(newState);
    try {
      final filesDM = state.files?.map((file) {
        final fileName = file.path.split('/').last;
        return FileDM(
          file: file,
          name: fileName,
        );
      }).toList();

      await serviceRepository.sendChatMessage(
        disputeId: disputeId,
        message: state.message,
        files: filesDM,
      );
      final newState = state.copyWith(
        submissionStatus: ChatSubmissionStatus.success,
      );
      emit(newState);
      final initialState = ChatState(
        dateGroupedMessages: state.dateGroupedMessages,
        userToken: state.userToken,
        dispute: state.dispute,
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
    serviceRepository.stopListeningChat(disputeId);
    serviceRepository.disconnectPusher();
    serviceRepository.changeNotifier.chatMessageVN
        .removeListener(_chatSubjectCallBack);
    serviceRepository.changeNotifier.currentDisputeVN
        .removeListener(_currentDisputeCallBack);


    serviceRepository.changeNotifier.clearDisputeChatUserType();
    serviceRepository.changeNotifier.clearCurrentDispute();
    serviceRepository.changeNotifier.clearChatMessage();

    return super.close();
  }
}
