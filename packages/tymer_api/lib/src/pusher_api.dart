import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart' as pusher;

// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:rxdart/subjects.dart';
import 'package:tymer_api/src/models/models.dart';
import 'package:tymer_api/src/tymer_api.dart';

class PusherApi {
  PusherApi(
    this.userTokenSupplier,
  ) : disputeChatMessageSC = BehaviorSubject();

  final BehaviorSubject<DisputeMessageRM> disputeChatMessageSC;
  PusherChannel? _chatChannel;
  Echo? _echo;
  final UserTokenSupplier userTokenSupplier;

  // void subscribeToChannel({
  //   PusherChannel? pusherChannel,
  //   required String channelName,
  //   required Function onEvent,
  // }) async {
  //   pusherChannel = _pusher.getChannel(channelName) ??
  //       await _pusher.subscribe(
  //         channelName: channelName,
  //         onEvent: onEvent,
  //       );
  // }
  //
  // void subscribeToRequesterChat({required int disputeId}) {
  //   subscribeToChannel(
  //     pusherChannel: _chatChannel,
  //     channelName: '${_ChannelNames.requestChat}.$disputeId',
  //     onEvent: _chatEvent,
  //   );
  // }
  //
  // void unsubscribeFromChannel(String channelName) async {
  //   await _pusher.unsubscribe(channelName: channelName);
  //   log('UNSUBSCRIBED SUCCESSFULLY FROM:::$channelName');
  // }
  //
  // void unsubscribeFromChat({required int companyId}) async {
  //   unsubscribeFromChannel('${_ChannelNames.chat}.$companyId');
  // }

  Future<void> initPusher() async {
    final token = await userTokenSupplier();
    Echo<pusher.PusherClient, PusherChannel> echo =
        Echo<pusher.PusherClient, PusherChannel>(PusherConnector(
      'tiqtbchiyhda7kZ0mnbz',
      authEndPoint: 'https://api.tymer-eg.com/api/v1/auth/broadcasting',
      authHeaders: {
        'Authorization': 'Bearer $token',
        'X-API-Key': '01f64a264be7442a9008abda93d5d6ae',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      host: 'api.tymer-eg.com',
      encrypted: false,
    ));
  }

  // Future<void> disconnectPusher() async {
  //   try {
  //     await _pusher.disconnect();
  //   } catch (e) {
  //     log('Error disconnecting pusher::::::$e');
  //   }
  // }

  void _chatEvent(dynamic event) {
    Map<String, dynamic> data = json.decode(event.data);
    log('CHAT EVENT:::$data');
    final DisputeMessageRM dateGroupedChatsRM = DisputeMessageRM.fromJson(data);
    disputeChatMessageSC.add(dateGroupedChatsRM);
    // final OfferRM? offerRM = OfferRM.fromJson(data[_offerJsonKey]);
    // offerRM != null ? chatSC.add(offerRM) : chatSC.add(null);
  }
}

class _ChannelNames {
  const _ChannelNames._();

  static String get requestChat => 'disputeChats';

  static String get providerChat => 'disputeSelectedUserChats';
}
