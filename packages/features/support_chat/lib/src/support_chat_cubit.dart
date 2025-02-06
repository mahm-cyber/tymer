import 'dart:async';
import 'dart:io';
import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:support_repository/support_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user_repository/user_repository.dart';

part 'support_chat_state.dart';

class SupportChatCubit extends Cubit<SupportChatState> {
  SupportChatCubit({
    required this.supportRepository,
    required this.userRepository,
    required this.onSupportChatClosed,
  })  : _imagePicker = ImagePicker(),
        super(
          const SupportChatState(),
        ) {
    init();
  }

  final scrollController = ScrollController();
  final SupportRepository supportRepository;
  final UserRepository userRepository;
  final ImagePicker _imagePicker;
  final VoidCallback onSupportChatClosed;
  final TextEditingController messageController = TextEditingController();

  Future<void> getFaqs() async {
    final settings =
        await userRepository.getSettings(FetchPolicy.cachePreferably);
    final successState = state.copyWith(
      faqs: settings.faqs,
    );
    emit(successState);
  }

  Future init() async {
    await getFaqs();
    final chatId = await checkIfUserHasSupportChat();
    final hasSupportChat = chatId != null;
    if (hasSupportChat) {
      await getSupportChat(chatId: chatId);
      await initPusher(chatId);
    }
  }

  Future<int?> checkIfUserHasSupportChat() async {
    final loadingState = state.copyWith(
      supportChatExistenceCheckFetchStatus:
          SupportChatExistenceCheckFetchStatus.inProgress,
    );
    emit(loadingState);
    try {
      final chatId = await supportRepository.checkIfUserHasSupportChat();
      final successState = state.copyWith(
        supportChatExistenceCheckFetchStatus:
            SupportChatExistenceCheckFetchStatus.success,
        chatId: chatId,
      );
      emit(successState);
      return chatId;
    } catch (e) {
      final failureState = state.copyWith(
        supportChatExistenceCheckFetchStatus:
            SupportChatExistenceCheckFetchStatus.failure,
      );
      emit(failureState);
      rethrow;
    }
  }

  void _supportChatSubjectCallBack() {
    final supportChatMessage =
        supportRepository.changeNotifier.supportChatMessageVN.value;
    if (supportChatMessage == null) return;
    final isFirstMessage = state.dateGroupedMessages == null ||
        state.dateGroupedMessages?.list.isEmpty == true;
    if (isFirstMessage) {
      final newGroupedMessages = DateGroupedMessages(
        date: supportChatMessage.date,
        messages: [supportChatMessage],
      );
      final groupedMessagesUpdated = DateGroupedMessagesList(
        list: [newGroupedMessages],
      );
      final updatedState = state.copyWith(
        dateGroupedMessages: groupedMessagesUpdated,
      );
      emit(const SupportChatState());
      emit(updatedState);
      jumpToBottomOfSupportChat();
      return;
    }

    final lastDateGroupedMessages = state.dateGroupedMessages?.list.last;
    final lastDate = lastDateGroupedMessages?.date;
    final newDate = supportChatMessage.date;
    final isSameDay = lastDate?.year == newDate.year &&
        lastDate?.month == newDate.month &&
        lastDate?.day == newDate.day;
    final messageAlreadyExists = lastDateGroupedMessages?.messages.any(
      (element) => element.id == supportChatMessage.id,
    );
    if (messageAlreadyExists == true) return;

    if (isSameDay) {
      final lastGroupedMessagesUpdated = lastDateGroupedMessages?.copyWith(
        messages: [
          ...lastDateGroupedMessages.messages,
          supportChatMessage,
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
        emit(const SupportChatState());
        emit(updatedState);
        jumpToBottomOfSupportChat();
      }
    } else {
      final newGroupedMessages = DateGroupedMessages(
        date: newDate,
        messages: [supportChatMessage],
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
      emit(const SupportChatState());
      emit(updatedState);
      jumpToBottomOfSupportChat();
      return;
    }
  }

  void _supportChatClosedSubjectCallBack() {
    final supportChatClosed =
        supportRepository.changeNotifier.supportChatClosedVN.value;
    if (supportChatClosed == true) {
      final chatClosedState = state.copyWith(
        supportChatClosed: supportChatClosed,
      );
      emit(chatClosedState);
    }
  }

  // void _currentDisputeCallBack() {
  // final dispute = disputeRepository.changeNotifier.currentDisputeVN.value;
  // final newState = state.copyWith(
  //   dispute: dispute,
  // );
  // if (!isClosed) emit(newState);
  // disputeRepository.changeNotifier.setShouldReFetchDisputes(true);
  // }

  // get support chat messages
  Future getSupportChat({
    required int chatId,
  }) async {
    final loadingState = state.copyWith(
      supportChatFetchingStatus: SupportChatFetchingStatus.inProgress,
      chatId: chatId,
    );
    emit(loadingState);
    final user = await userRepository.getUser().first;
    final userToken = await userRepository.getUserToken();
    try {
      final dateGroupedSupportChats =
          await supportRepository.getDateGroupedSupportChat(
        chatId,
        user!,
      );
      final successState = state.copyWith(
        supportChatFetchingStatus: SupportChatFetchingStatus.success,
        dateGroupedMessages: dateGroupedSupportChats,
        userToken: userToken,
      );
      emit(successState);
      jumpToBottomOfSupportChat();
    } catch (_) {
      final failureState = state.copyWith(
        supportChatFetchingStatus: SupportChatFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

  Future<void> initPusher(int chatId) async {
    supportRepository.initPusher().then((_) async {
      await Future.delayed(const Duration(seconds: 1));
      supportRepository.listenToSupportChat(chatId);
    });
    final user = await userRepository.getUser().first;
    supportRepository.initializeSupportChatStream(user!, chatId);
    supportRepository.changeNotifier.supportChatMessageVN
        .addListener(_supportChatSubjectCallBack);
    supportRepository.changeNotifier.supportChatClosedVN
        .addListener(_supportChatClosedSubjectCallBack);
  }

  Future createSupportChat() async {
    final loadingState = state.copyWith(
      supportChatCreationStatus: SupportChatCreationStatus.inProgress,
    );
    emit(loadingState);
    try {
      final chatId = await supportRepository.createSupportChat();
      await getSupportChat(chatId: chatId);
      await initPusher(chatId);
      final successState = state.copyWith(
        supportChatCreationStatus: SupportChatCreationStatus.success,
        chatId: chatId,
      );
      emit(successState);
    } catch (_) {
      final failureState = state.copyWith(
        supportChatCreationStatus: SupportChatCreationStatus.failure,
      );
      emit(failureState);
    }
  }

  void jumpToBottomOfSupportChat() {
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
      imageQuality: 35,
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
    final newState = SupportChatState(
      chatId: state.chatId,
      dateGroupedMessages: state.dateGroupedMessages,
      supportChatFetchingStatus: state.supportChatFetchingStatus,
      submissionStatus: state.submissionStatus,
      message: state.message,
      files: const [],
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
      submissionStatus: SupportChatSubmissionStatus.inProgress,
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

      await supportRepository.sendSupportChatMessage(
        supportChatId: state.chatId!,
        message: state.message,
        files: filesDM,
      );
      final newState = state.copyWith(
        submissionStatus: SupportChatSubmissionStatus.success,
      );
      emit(newState);
      final initialState = SupportChatState(
        dateGroupedMessages: state.dateGroupedMessages,
        userToken: state.userToken,
        chatId: state.chatId,
      );
      emit(initialState);
      messageController.clear();
      // getSupportChat();
    } catch (e) {
      final failureState = state.copyWith(
        submissionStatus: SupportChatSubmissionStatus.failure,
      );
      emit(failureState);
      rethrow;
    }
  }

  @override
  Future<void> close() {
    supportRepository.disconnectPusher();
    supportRepository.changeNotifier.supportChatMessageVN
        .removeListener(_supportChatSubjectCallBack);
    supportRepository.changeNotifier.clearSupportChatMessage();
    return super.close();
  }
}
