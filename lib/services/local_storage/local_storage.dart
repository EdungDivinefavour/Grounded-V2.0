import 'dart:convert';

import 'package:grounded/models/grounded_user/grounded_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();
  static final LocalStorage _instance = LocalStorage._();
  static LocalStorage get instance => _instance;

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<GroundedUser?> getUserInfoFromLocal() async {
    final userInfo = _prefs.getString("userInfo");
    if (userInfo == null) {
      return null;
    }

    return GroundedUser.fromJson(jsonDecode(userInfo));
  }

  Future<void> storeUserInfoToLocal(GroundedUser groundedUser) async {
    await _prefs.setString("userInfo", jsonEncode(groundedUser.toJson()));
  }

  Future<void> clearUserInfoFromLocal() {
    return _prefs.remove("userInfo");
  }
}
