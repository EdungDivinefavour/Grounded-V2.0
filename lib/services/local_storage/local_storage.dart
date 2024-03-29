import 'dart:convert';

import 'package:grounded/constants/enums/user_type.dart';
import 'package:grounded/models/grounded_user/child/child.dart';
import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:grounded/models/grounded_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();
  static final LocalStorage _instance = LocalStorage._();
  static LocalStorage get instance => _instance;

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<dynamic> getUserInfoFromLocal() async {
    final result = _prefs?.getString("userInfo");
    if (result == null) return null;

    final userInfo = GroundedUser.fromJson(jsonDecode(result));
    if (userInfo.userType == UserType.parent) {
      return Parent.fromJson(jsonDecode(result));
    } else {
      return Child.fromJson(jsonDecode(result));
    }
  }

  Future<void> storeUserInfoToLocal(GroundedUser groundedUser) async {
    await _prefs?.setString("userInfo", jsonEncode(groundedUser.toJson()));
  }

  Future<bool>? clearUserInfoFromLocal() {
    return _prefs?.remove("userInfo");
  }

  Future<void> storeNotificationToLocal(
    GroundedNotification notification,
  ) async {
    final notifications = (await getNotificationsFromLocal()) ?? [];
    notifications.insert(0, notification);

    final jsonStringList = jsonEncode(
      notifications
          .map<Map<String, dynamic>>((notification) => notification.toJson())
          .toList(),
    );

    await _prefs?.setString("notifications", jsonStringList);
  }

  Future<List<GroundedNotification>?> getNotificationsFromLocal() async {
    final result = _prefs?.getString("notifications");
    if (result == null) return null;

    return GroundedNotification.fromJsonList(jsonDecode(result));
  }
}
