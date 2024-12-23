import 'dart:async';
import 'dart:io';

import 'package:dispute_repository/dispute_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_repository/user_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.disputeRepository,
    required this.userRepository,
    required this.disputeId,
  })  : _imagePicker = ImagePicker(),
        super(
          ChatState(
            dispute: disputeRepository.changeNotifier.currentDisputeVN.value,
          ),
        ) {
    init();
  }

  final scrollController = ScrollController();
  final DisputeRepository disputeRepository;
  final UserRepository userRepository;
  final ImagePicker _imagePicker;
  final TextEditingController messageController = TextEditingController();
  final int disputeId;

  Future init() async {
    await getDispute();
    await getChat();
    disputeRepository.initPusher().then((_) async {
      await Future.delayed(const Duration(seconds: 1));
      disputeRepository.listenToChat(disputeId);
    });
    final user = await userRepository.getUser().first;
    disputeRepository.initializeChatStream(user!, disputeId);
    disputeRepository.changeNotifier.chatMessageVN
        .addListener(_chatSubjectCallBack);

    disputeRepository.initializeDisputeResolutionStream();
    disputeRepository.changeNotifier.currentDisputeVN
        .addListener(_currentDisputeCallBack);
  }

  Future getDispute() async {
    final loadingState = state.copyWith(
      disputeFetchStatus: DisputeFetchStatus.inProgress,
    );
    emit(loadingState);
    try {
      final disputeFromDisputesScreen =
          disputeRepository.changeNotifier.currentDisputeVN.value;
      final freshDispute = await disputeRepository.getDispute(disputeId);
      final hasSameStatus =
          disputeFromDisputesScreen?.status == freshDispute.status;
      if (!hasSameStatus) {
        disputeRepository.changeNotifier.setShouldReFetchDisputes(true);
      }

      final successState = state.copyWith(
        disputeFetchStatus: DisputeFetchStatus.success,
        dispute: !hasSameStatus ? freshDispute : disputeFromDisputesScreen,
      );
      emit(successState);
    } catch (_) {
      final failureState = state.copyWith(
        disputeFetchStatus: DisputeFetchStatus.failure,
      );
      emit(failureState);
    }
  }

  void _chatSubjectCallBack() {
    final chatMessage = disputeRepository.changeNotifier.chatMessageVN.value;
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
    final dispute = disputeRepository.changeNotifier.currentDisputeVN.value;
    final newState = state.copyWith(
      dispute: dispute,
    );
    if (!isClosed) emit(newState);
    disputeRepository.changeNotifier.setShouldReFetchDisputes(true);
  }

  // get ticket_messages
  Future getChat() async {
    final loadingState =
        state.copyWith(chatFetchingStatus: ChatFetchingStatus.inProgress);
    emit(loadingState);
    final user = await userRepository.getUser().first;
    final userToken = await userRepository.getUserToken();
    try {
      final dateGroupedChats = await disputeRepository.getDateGroupedChat(
        disputeId,
        user!,
      );
      final successState = state.copyWith(
        chatFetchingStatus: ChatFetchingStatus.success,
        dateGroupedMessages: dateGroupedChats,
        userToken: userToken,
      );
      emit(successState);
      jumpToBottomOfChat();
    } catch (_) {
      final failureState = state.copyWith(
        chatFetchingStatus: ChatFetchingStatus.failure,
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
        'jpg',
        'jpeg',
        'png',
      ],
    );

    if (result != null) {
      final files = result.files
          .map(
            (platformFile) => FileSize<File?>.validated(
              File(platformFile.path!),
              sizeLimitInKb: 1024,
            ),
          )
          .toList();

      final newState = state.copyWith(
        files: [...files],
      );
      emit(newState);
      final isNotValid = files.any((file) => file.isNotValid);
      final deleteAllFilesState = state.copyWith(
        files: const [],
      );
      if (isNotValid) {
        emit(deleteAllFilesState);
      }
    } else {
      // User canceled the picker
    }
  }

  Future<void> pickImageFromGallery() async {
    XFile? xFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    onImagePicked(xFile);
  }

  Future<void> capturePhoto() async {
    XFile? xFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
    onImagePicked(xFile);
  }

  void onImagePicked(XFile? xFile) {
    if (xFile != null) {
      File? file = File(
        xFile.path.toString(),
      );
      final validatedFile = FileSize<File?>.validated(
        file,
        sizeLimitInKb: 1024,
      );
      final imagePicked = state.copyWith(
        files: [validatedFile],
      );
      emit(imagePicked);
      final isNotValid = validatedFile.isNotValid;
      final deleteAllFilesState = state.copyWith(
        files: const [],
      );
      if (isNotValid) {
        emit(deleteAllFilesState);
      }


    }
  }

  void deletePickedFile() {
    final newState = ChatState(
      dateGroupedMessages: state.dateGroupedMessages,
      chatFetchingStatus: state.chatFetchingStatus,
      submissionStatus: state.submissionStatus,
      message: state.message,
      files: const [],
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
      final filesDM = state.files.map((file) {
        final fileName = file.value?.path.split('/').last;
        return FileDM(
          file: file.value,
          name: fileName ?? '',
        );
      }).toList();

      await disputeRepository.sendChatMessage(
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

  UserType getCurrentChatUserType() {
    return disputeRepository.changeNotifier.disputeChatUserType!;
  }

  @override
  Future<void> close() {
    disputeRepository.stopListeningChat(disputeId);
    disputeRepository.disconnectPusher();
    disputeRepository.changeNotifier.chatMessageVN
        .removeListener(_chatSubjectCallBack);
    disputeRepository.changeNotifier.currentDisputeVN
        .removeListener(_currentDisputeCallBack);

    disputeRepository.changeNotifier.clearDisputeChatUserType();
    disputeRepository.changeNotifier.clearCurrentDispute();
    disputeRepository.changeNotifier.clearChatMessage();

    return super.close();
  }
}
