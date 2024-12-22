import 'dart:async';
import 'dart:developer';

import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart' as pusher;

import 'package:rxdart/subjects.dart';
import 'package:tymer_api/src/models/models.dart';
import 'package:tymer_api/src/tymer_api.dart';

class PusherApi {
  PusherApi(
    this.userTokenSupplier,
  )   : disputeChatMessageSC = BehaviorSubject(),
        disputeStatusSC = BehaviorSubject();

  final BehaviorSubject<DisputeMessageRM?> disputeChatMessageSC;
  final BehaviorSubject<String?> disputeStatusSC;
  Echo<pusher.PusherClient, PusherChannel>? _echo;
  final UserTokenSupplier userTokenSupplier;

  void listenToChannel({
    required String channelName,
    required Function onEvent,
    required String eventName,
  }) async {
    try {
      final privateChannel = _echo?.private(channelName);
      // privateChannel?.onSubscribedSuccess(_onSubscriptionSucceeded);
      // privateChannel?.unsubscribe();
      privateChannel?.subscribe();

      privateChannel?.listen(
        eventName,
        _disputeChatEvent,
      );

      log('LISTENING TO:::$channelName::::::$eventName');
    } catch (e) {
      log('Error listening to channel:::$e');
    }
  }

  void stopListeningToChannel({
    required String channelName,
    required Function onEvent,
  }) async {
    final privateChannel = _echo?.private(channelName);
    // privateChannel?.unsubscribe();
    privateChannel?.stopListening(channelName, onEvent);
    log('STOPPED LISTENING TO:::$channelName');
  }

  void listenToRemoteChat({
    required int disputeId,
    required String userType,
  }) {
    final isRequester = userType == 'requester';
    final channelName =
        isRequester ? _ChannelNames.requestChat : _ChannelNames.providerChat;
    final eventName = isRequester
        ? _ChannelNames.requestChatEventName
        : _ChannelNames.providerChatEventName;

    listenToChannel(
      channelName: '$channelName.$disputeId',
      eventName: eventName,
      onEvent: _disputeChatEvent,
    );
  }

  void stopListeningToRemoteChat({
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

  void listenToChatResolved({
    required int disputeId,
    required String userType,
  }) {
    final isRequester = userType == 'requester';
    final channelName =
        isRequester ? _ChannelNames.requestChat : _ChannelNames.providerChat;

    listenToChannel(
      channelName: '$channelName.$disputeId',
      eventName: _ChannelNames.disputeResolvedAndClosedEventName,
      onEvent: _disputeChatEvent,
    );
  }

  void stopListeningToChatResolved({
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

  Future initPusher() async {
    try {
      final token = await userTokenSupplier();
      _echo = Echo<pusher.PusherClient, PusherChannel>(
        PusherConnector(
          'tiqtbchiyhda7kZ0mnbz',
          enableLogging: true,
          authEndPoint: 'https://api.tymer-eg.com/api/v1/auth/broadcasting',
          authHeaders: {
            'Authorization': 'Bearer $token',
            'X-API-Key': const String.fromEnvironment('x-api-key'),
            // 'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          host: 'api.tymer-eg.com',
          encrypted: false,

          // cluster: 'eu',
          // wsPort: 6001,
          // wssPort: 443,
        ),
      );
      _echo?.disconnect();
      _echo?.connect();
    } catch (e) {
      log('Error initializing pusher::::::$e');
    }
  }

  Future<void> disconnectPusher() async {
    try {
      _echo?.disconnect();
      _echo = null;
    } catch (e) {
      log('Error disconnecting pusher::::::$e');
    }
  }

  void _disputeChatEvent(Map<String, dynamic> event) {
    log('CHAT EVENT:::$event');

    // Map<String, dynamic> data = json.decode(event);
    // check if the json has the following keys sender_id
    // sender_name
    if (event.containsKey('sender_id') && event.containsKey('sender_name')) {
      final DisputeMessageRM dateGroupedChatsRM =
          DisputeMessageRM.fromJson(event);
      disputeChatMessageSC.add(dateGroupedChatsRM);
    }
    if (event.containsKey('new_status')) {
      final String newStatus = event['new_status'];
      disputeStatusSC.add(newStatus);
    }
  }
}

class _ChannelNames {
  const _ChannelNames._();

  static String get requestChat => 'disputeChats';

  static String get requestChatEventName =>
      'App\\Events\\DisputeChatMessageSent';

  static String get providerChat => 'disputeSelectedUserChats';

  static String get providerChatEventName =>
      'App\\Events\\DisputeSelectedUserChatMessageSent';

  static String get disputeResolvedAndClosedEventName =>
      'App\\Events\\DisputeResolvedAndClosed';
}
