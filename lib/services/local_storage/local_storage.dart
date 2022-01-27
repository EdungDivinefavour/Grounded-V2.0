import 'dart:convert';

import 'package:grounded/models/grounded_user/parent/parent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();
  static final LocalStorage _instance = LocalStorage._();
  static LocalStorage get instance => _instance;

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<Parent?> getParentInfoFromLocal() async {
    final parentInfo = _prefs.getString("parentInfo");
    if (parentInfo == null) {
      return null;
    }

    return Parent.fromJson(jsonDecode(parentInfo));
  }

  Future<void> storeParentInfoToLocal(Parent parent) async {
    await _prefs.setString("parentInfo", jsonEncode(parent.toJson()));
  }

  Future<void> clearParentInfoFromLocal() {
    return _prefs.remove("parentInfo");
  }
}
