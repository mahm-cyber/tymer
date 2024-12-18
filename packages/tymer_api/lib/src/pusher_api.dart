import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart' as pusher;

import 'package:rxdart/subjects.dart';
import 'package:tymer_api/src/models/models.dart';
import 'package:tymer_api/src/tymer_api.dart';

class PusherApi {
  PusherApi(
    this.userTokenSupplier,
  ) : disputeChatMessageSC = BehaviorSubject();

  final BehaviorSubject<DisputeMessageRM> disputeChatMessageSC;
  Echo<pusher.PusherClient, PusherChannel>? _echo;
  final UserTokenSupplier userTokenSupplier;

  void listenToChannel({
    required String channelName,
    required Function onEvent,
    required String eventName,
  }) async {
    final privateChannel = _echo?.private(channelName);
    privateChannel?.unsubscribe();
    privateChannel?.subscribe();
    privateChannel?.listen(eventName, onEvent);
    log('LISTENING TO:::$channelName');
  }

  void stopListeningToChannel({
    required String channelName,
    required Function onEvent,
  }) async {
    final privateChannel = _echo?.private(channelName);
    privateChannel?.unsubscribe();
    privateChannel?.stopListening(channelName, onEvent);
    log('STOPPED LISTENING TO:::$channelName');
  }

  void listenToChat({
    required int disputeId,
    required String userType,
  }) {
    final isRequester = userType == 'requester';
    final channelName =
        isRequester ? _ChannelNames.requestChat : _ChannelNames.providerChat;
    final eventName = isRequester
        ? 'requester-dispute-chat-event'
        : 'provider-dispute-chat-event';
    listenToChannel(
      channelName: '$channelName.$disputeId',
      eventName: eventName,
      onEvent: _disputeChatEvent,
    );
  }

  void stopListeningToChat({
    required int disputeId,
    required String userType,
  }) {
    final isRequester = userType == 'requester';
    final channelName =
        isRequester ? _ChannelNames.requestChat : _ChannelNames.providerChat;
    stopListeningToChannel(
      channelName: '$channelName.$disputeId',
      onEvent: _disputeChatEvent,
    );
  }

  void _onSubscriptionSucceeded(String channelName, dynamic data) {
    log('SubscriptionSucceeded: $channelName data: $data');
  }

  Future<void> initPusher() async {
    try {
      final token = await userTokenSupplier();
      _echo = Echo<pusher.PusherClient, PusherChannel>(
        PusherConnector(
          'tiqtbchiyhda7kZ0mnbz',
          enableLogging: true,
          authEndPoint: 'https://api.tymer-eg.com/api/v1/auth/broadcasting',
          authHeaders: {
            'Authorization': 'Bearer $token',
            'X-API-Key': '01f64a264be7442a9008abda93d5d6ae',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          host: 'api.tymer-eg.com',
          encrypted: false,
        ),
      );
      _echo?.connect();
    } catch (e) {
      log('Error initializing pusher::::::$e');
    }
  }

  Future<void> disconnectPusher() async {
    try {
      _echo?.disconnect();
    } catch (e) {
      log('Error disconnecting pusher::::::$e');
    }
  }

  void _disputeChatEvent(dynamic event) {
    Map<String, dynamic> data = json.decode(event.data);
    // check if the json has the following keys sender_id
    // sender_name
    log('CHAT EVENT:::$data');
    if (data.containsKey('sender_id') && data.containsKey('sender_name')) {
      final DisputeMessageRM dateGroupedChatsRM =
          DisputeMessageRM.fromJson(data);
      disputeChatMessageSC.add(dateGroupedChatsRM);
    }
  }
}

class _ChannelNames {
  const _ChannelNames._();

  static String get requestChat => 'disputeChats';

  static String get providerChat => 'disputeSelectedUserChats';
}
