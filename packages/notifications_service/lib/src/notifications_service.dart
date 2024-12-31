import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// @pragma('vm:entry-point')
// Future<void> _handleBackgroundMessage(RemoteMessage message) async {
//   final notificationsService = NotificationsService.instance;
//   notificationsService.showFlutterNotification(message);
// }

class NotificationsService {
  NotificationsService._();

  static final instance = NotificationsService._();
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const _channel = AndroidNotificationChannel(
    'tymer-notification-channel',
    'Tymer Notification Channel',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  Future<void> init({
    required ValueSetter<int> goToFulfillServiceScreen,
    required ValueSetter<int> goToRequestStatusScreen,
    required ValueSetter<int> goToRequesterDisputeChatScreen,
    required ValueSetter<int> goToProviderDisputeChatScreen,
  }) async {
    await _requestPermission();
    await _setupNotifications(
      goToFulfillServiceScreen,
      goToRequestStatusScreen,
      goToRequesterDisputeChatScreen,
      goToProviderDisputeChatScreen,
    );
  }

  // Request permission for notifications
  Future<void> _requestPermission() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  // Setup notification handling
  Future<void> _setupNotifications(
    ValueSetter<int> goToFulfillServiceScreen,
    ValueSetter<int> goToRequestStatusScreen,
    ValueSetter<int> goToRequesterDisputeChatScreen,
    ValueSetter<int> goToProviderDisputeChatScreen,
  ) async {
    FirebaseMessaging.onMessage.listen(
      (message) => showFlutterNotification(message),
    );
    // FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleNotificationNavigation(
        message,
        goToFulfillServiceScreen,
        goToRequestStatusScreen,
        goToRequesterDisputeChatScreen,
        goToProviderDisputeChatScreen,
      );
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationNavigation(
          message,
          goToFulfillServiceScreen,
          goToRequestStatusScreen,
          goToRequesterDisputeChatScreen,
          goToProviderDisputeChatScreen,
        );
      }
    });

    // Initialize local notifications
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/notification_icon'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) async {
        final payload =
            response.payload != null ? jsonDecode(response.payload!) : {};
        final title = payload['title'];
        _handleNotificationNavigationFromResponse(
          title,
          payload,
          goToFulfillServiceScreen,
          goToRequestStatusScreen,
          goToRequesterDisputeChatScreen,
          goToProviderDisputeChatScreen,
        );
      },
    );
  }

  // Show Flutter notification
  void showFlutterNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification != null) {
      final payload = {...message.data, 'title': notification.title};
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
            channelDescription: _channel.description,
            importance: Importance.high,
            color: const Color(0xFF2C8268),
            icon: '@mipmap/notification_icon',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
      );
    }
  }

  // Handle notification navigation when a notification is clicked
  void _handleNotificationNavigation(
    RemoteMessage message,
    ValueSetter<int> goToFulfillServiceScreen,
    ValueSetter<int> goToRequestStatusScreen,
    ValueSetter<int> goToRequesterDisputeChatScreen,
    ValueSetter<int> goToProviderDisputeChatScreen,
  ) {
    final title = message.notification?.title ?? '';
    final serviceId = message.data['service_request_id'];
    final disputeId = message.data['dispute_id'];

    if (_shouldNavigateToFulfillServiceRequestScreen(title)) {
      goToFulfillServiceScreen(int.parse(serviceId));
    } else if (_shouldNavigateToRequestStatusScreen(title)) {
      goToRequestStatusScreen(int.parse(serviceId));
    } else if (_shouldNavigateToRequesterDisputeChatScreen(title)) {
      goToRequesterDisputeChatScreen(int.parse(disputeId));
    } else if (_shouldNavigateToProviderDisputeChatScreen(title)) {
      goToProviderDisputeChatScreen(int.parse(disputeId));
    }
  }

  // Handle notification navigation from background or terminated state
  void _handleNotificationNavigationFromResponse(
    String title,
    Map<String, dynamic> payload,
    ValueSetter<int> goToFulfillServiceScreen,
    ValueSetter<int> goToRequestStatusScreen,
    ValueSetter<int> goToRequesterDisputeChatScreen,
    ValueSetter<int> goToProviderDisputeChatScreen,
  ) {
    final serviceId = payload['service_request_id'];
    final disputeId = payload['dispute_id'];

    if (_shouldNavigateToFulfillServiceRequestScreen(title)) {
      goToFulfillServiceScreen(int.parse(serviceId));
    } else if (_shouldNavigateToRequestStatusScreen(title)) {
      goToRequestStatusScreen(int.parse(serviceId));
    } else if (_shouldNavigateToRequesterDisputeChatScreen(title)) {
      goToRequesterDisputeChatScreen(int.parse(disputeId));
    } else if (_shouldNavigateToProviderDisputeChatScreen(title)) {
      goToProviderDisputeChatScreen(int.parse(disputeId));
    }
  }

  // Check if should navigate to Request Status screen
  bool _shouldNavigateToRequestStatusScreen(String? title) {
    if (title == null) return false;
    return title.contains('Service Request Accepted') ||
        (title.contains('Response Received'));
  }

  // Check if should navigate to Fulfill Service screen
  bool _shouldNavigateToFulfillServiceRequestScreen(String? title) {
    if (title == null) return false;
    return title.contains('Response Accepted');
  }

  // Check if should navigate to Requester Dispute Chat screen
  bool _shouldNavigateToRequesterDisputeChatScreen(String? title) {
    if (title == null) return false;
    return title.contains('Dispute Chat Message Received') ||
        (title.contains('Dispute Raised by You'));
  }

  // Check if should navigate to Provider Dispute Chat screen
  bool _shouldNavigateToProviderDisputeChatScreen(String? title) {
    if (title == null) return false;
    return title.contains('Dispute Selected User Chat Message Received') ||
        title.contains('Dispute Raised Against You') ||
        title.contains('Response Refused');
  }
}
