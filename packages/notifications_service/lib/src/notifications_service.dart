import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  NotificationsService._();

  static final NotificationsService instance = NotificationsService._();
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const _channel = AndroidNotificationChannel(
    'tymer-notification-channel', // id
    'Tymer Notification Channel', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  Future<void> init({
    required ValueSetter<int> goToFulfillServiceScreen,
    required ValueSetter<int> goToRequestStatusScreen,
    required ValueSetter<int> goToRequesterDisputeChatScreen,
    required ValueSetter<int> goToProviderDisputeChatScreen,
  }) async {
    await _requestPermission();
    await _setupFlutterNotifications(
      goToFulfillServiceScreen: goToFulfillServiceScreen,
      goToRequestStatusScreen: goToRequestStatusScreen,
      goToRequesterDisputeChatScreen: goToRequesterDisputeChatScreen,
      goToProviderDisputeChatScreen: goToProviderDisputeChatScreen,
    );
  }

  Future<void> _requestPermission() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    final settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> _setupFlutterNotifications({
    required ValueSetter<int> goToFulfillServiceScreen,
    required ValueSetter<int> goToRequestStatusScreen,
    required ValueSetter<int> goToRequesterDisputeChatScreen,
    required ValueSetter<int> goToProviderDisputeChatScreen,
  }) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final title = message.notification?.title ?? '';
      if (_shouldNavigateToFulfillServiceRequestScreen(title) ||
          _shouldNavigateToRequestStatusScreen(title)) {
        final serviceId = message.data['service_request_id'];
        if (_shouldNavigateToFulfillServiceRequestScreen(title)) {
          goToFulfillServiceScreen(int.parse(serviceId));
        } else {
          goToRequestStatusScreen(int.parse(serviceId));
        }

      }
      if (_shouldNavigateToRequesterDisputeChatScreen(title) ||
          _shouldNavigateToProviderDisputeChatScreen(title)) {
        final disputeId = message.data['dispute_id'];
        if (_shouldNavigateToRequesterDisputeChatScreen(title)) {
          goToRequesterDisputeChatScreen(int.parse(disputeId));
        } else {
          goToProviderDisputeChatScreen(int.parse(disputeId));
        }
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      final title = message?.notification?.title ?? '';
      if (_shouldNavigateToFulfillServiceRequestScreen(title) ||
          _shouldNavigateToRequestStatusScreen(title)) {
        final serviceId = message?.data['service_request_id'];
        if (_shouldNavigateToFulfillServiceRequestScreen(title)) {
          goToFulfillServiceScreen(int.parse(serviceId));
        } else {
          goToRequestStatusScreen(int.parse(serviceId));
        }
      }

      if (_shouldNavigateToRequesterDisputeChatScreen(title) ||
          _shouldNavigateToProviderDisputeChatScreen(title)) {
        final disputeId = message?.data['dispute_id'];
        if (_shouldNavigateToRequesterDisputeChatScreen(title)) {
          goToRequesterDisputeChatScreen(int.parse(disputeId));
        } else {
          goToProviderDisputeChatScreen(int.parse(disputeId));
        }
      }
    });

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: android,
      iOS: ios,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final payload =
            response.payload != null ? jsonDecode(response.payload!) : null;
        final title = payload['title'];

        if (_shouldNavigateToRequestStatusScreen(title) ||
            _shouldNavigateToFulfillServiceRequestScreen(title)) {
          final serviceId = payload['service_request_id'];
          if (_shouldNavigateToFulfillServiceRequestScreen(title)) {
            goToFulfillServiceScreen(int.parse(serviceId));
          } else {
            goToRequestStatusScreen(int.parse(serviceId));
          }
        }
        if (_shouldNavigateToRequesterDisputeChatScreen(title) ||
            _shouldNavigateToProviderDisputeChatScreen(title)) {
          final disputeId = payload['dispute_id'];
          if (_shouldNavigateToRequesterDisputeChatScreen(title)) {
            goToRequesterDisputeChatScreen(int.parse(disputeId));
          } else {
            goToProviderDisputeChatScreen(int.parse(disputeId));
          }
        }
      },
    );
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? apple = message.notification?.apple;
    if (notification != null && (android != null || apple != null)) {
      final payload = {
        ...message.data,
        'title': notification.title,
      };
      final jsonPayload = jsonEncode(payload);
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonPayload,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            playSound: true,
            enableVibration: true,
            importance: Importance.high,
            channelDescription: _channel.description,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              subtitle: apple?.subtitle,
              badgeNumber: int.tryParse(apple?.badge ?? ''),
              presentBanner: true),
        ),
      );
    }
  }
}

bool _shouldNavigateToRequestStatusScreen(String title) {
  return title.contains('Service Request Accepted') ||
      title.contains('Response Received');
}

bool _shouldNavigateToFulfillServiceRequestScreen(String title) {
  return title.contains('Response Accepted');
}

bool _shouldNavigateToRequesterDisputeChatScreen(String title) {
  return title.contains('Dispute Chat Message Received') ||
      title.contains('Dispute Raised by You');
}

bool _shouldNavigateToProviderDisputeChatScreen(String title) {
  return title.contains('Dispute Selected User Chat Message Received') ||
      title.contains('Dispute Raised Against You') ||
      // this case the payload returns the request id not the dispute id, louise is working on it
      title.contains('Response Refused');
}
