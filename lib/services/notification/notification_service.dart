import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grounded/models/grounded_notification.dart';
import 'package:grounded/services/local_storage/local_storage.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService _instance = NotificationService._();
  static NotificationService get instance => _instance;

  final _localStorage = LocalStorage.instance;
  final _notificationHandler = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await _notificationHandler.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  void setupHandler(GlobalKey navigatorKey) {
    FirebaseMessaging.onMessage.listen((message) async {
      await _show(message);
      await _saveNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  }

  Future<void> _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {}

  Future<void> _onSelectNotification(String? onSelectNotification) async {}

  Future<void> _onBackgroundMessage(RemoteMessage message) async {
    await _show(message);
    await _saveNotification(message);
  }

  Future<void> _show(RemoteMessage message) async {
    await _notificationHandler.show((Random().nextInt(91039) + 29332),
        message.notification?.title, message.notification?.body, null,
        payload: message.data.toString());
  }

  Future<void> _saveNotification(RemoteMessage message) async {
    final notification = GroundedNotification(
      title: message.notification!.title!,
      body: message.notification!.body!,
      creationTimeStamp: DateTime.now().millisecondsSinceEpoch,
    );

    await _localStorage.storeNotificationToLocal(notification);
  }
}
