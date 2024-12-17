import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:service_repository/service_repository.dart';

import 'package:user_repository/user_repository.dart';

part 'dispute_chat_state.dart';

class DisputeChatCubit extends Cubit<DisputeChatState> {
  DisputeChatCubit({
    required this.userRepository,
    required this.serviceRepository,
    required this.disputeId,
  }) : super(
          const DisputeChatState(),
        ) {
    init();
  }

  final UserRepository userRepository;
  final ServiceRepository serviceRepository;
  final int disputeId;

  void init() {
    final loadingState =
        state.copyWith(messagesFetchStatus: FetchStatus.inProgress);
    emit(loadingState);

    userRepository.getUser().first.then((user) async {
      final token = await userRepository.getUserToken();
      final userDM = types.User(
        id: user!.id.toString(),
        firstName: user.name,
      );
      final userFetchedState = state.copyWith(
        user: userDM,
        userToken: token,
      );
      emit(userFetchedState);
      // loadMessages();
    });
  }

  // void loadMessages() async {
  //   try {
  //     final disputeChat = await serviceRepository.getDisputeChat(
  //       disputeId: disputeId,
  //     );
  //     final successState = state.copyWith(
  //       messagesFetchStatus: FetchStatus.success,
  //       messages: disputeChat.messages.reversed.toList(),
  //     );
  //     emit(successState);
  //   } catch (e) {
  //     emit(state.copyWith(messagesFetchStatus: FetchStatus.failure));
  //   }
  // }

  void handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              state.messages!.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (state.messages![index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          final updatedMessages = List<types.Message>.from(state.messages!);
          updatedMessages[index] = updatedMessage;
          emit(state.copyWith(messages: updatedMessages));

          final client = Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              state.messages!.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (state.messages![index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          final updatedMessages = List<types.Message>.from(state.messages!);
          updatedMessages[index] = updatedMessage;
          emit(state.copyWith(messages: updatedMessages));
        }
      }

      await OpenFilex.open(localPath);
    }
  }

// @override
// Future<void> close() async {
//
//
//   return super.close();
// }
}
