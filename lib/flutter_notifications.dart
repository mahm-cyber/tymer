import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tymer/firebase_options.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();
  static final _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const _channel = AndroidNotificationChannel(
    'tymer-notification-channel', // id
    'Tymer Notification Channel', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await _requestPermission();
    await _setupFlutterNotifications();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('onMessageOpenedApp: $message');
    });
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

  Future<void> _setupFlutterNotifications() async {
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
        debugPrint('onDidReceiveNotificationResponse: ${response}');
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
