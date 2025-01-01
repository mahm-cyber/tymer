import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_service/notifications_service.dart';
import 'package:tymer_api/tymer_api.dart';

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
        message.data,
        goToFulfillServiceScreen,
        goToRequestStatusScreen,
        goToRequesterDisputeChatScreen,
        goToProviderDisputeChatScreen,
      );
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationNavigation(
          message.data,
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
        _handleNotificationNavigation(
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
      final jsonPayload = jsonEncode(message.data);
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
    Map<String, dynamic> payload,
    ValueSetter<int> goToFulfillServiceScreen,
    ValueSetter<int> goToRequestStatusScreen,
    ValueSetter<int> goToRequesterDisputeChatScreen,
    ValueSetter<int> goToProviderDisputeChatScreen,
  ) {
    final notification = NotificationRM.fromJson(payload).toDomainModel();


    // Navigate to Fulfill Service Screen
    if (notification.shouldNavigateToFulfillServiceRequestScreen) {
      goToFulfillServiceScreen(notification.serviceRequestId!);
      return; // Early return to avoid checking other conditions
    }

    // Navigate to Request Status Screen
    if (notification.shouldNavigateToRequestStatusScreen) {
      goToRequestStatusScreen(notification.serviceRequestId!);
      return; // Early return
    }

    // Navigate to Requester's Dispute Chat
    if (notification.shouldNavigateToRequesterDisputeChatScreen) {
      goToRequesterDisputeChatScreen(notification.disputeId!);
      return; // Early return
    }

    // Navigate to Provider's Dispute Chat
    if (notification.shouldNavigateToProviderDisputeChatScreen) {
      goToProviderDisputeChatScreen(notification.disputeId!);
      return; // Early return
    }
  }
}
