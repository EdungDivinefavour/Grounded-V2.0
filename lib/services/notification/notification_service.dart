import 'package:flutter/material.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService _instance = NotificationService._();
  static NotificationService get instance => _instance;

  void setupHandler(GlobalKey navigatorKey) {}
}
