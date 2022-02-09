import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:grounded/constants/strings/paths.dart';

class LocalAsset {
  LocalAsset._();
  static final LocalAsset _instance = LocalAsset._();
  static LocalAsset get instance => _instance;

  Future<dynamic> readJSON(String source) {
    return rootBundle
        .loadString(mockDataPath + source)
        .then((jsonStr) => jsonDecode(jsonStr));
  }
}
