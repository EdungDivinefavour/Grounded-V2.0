import 'package:flutter/foundation.dart';

enum EnglishType {
  general,
}

extension EnglishTypeExtension on EnglishType {
  String get value => describeEnum(this);
}

extension EnglishTypeExtensionStringExtension on String {
  EnglishType get toEnglishType =>
      EnglishType.values.firstWhere((e) => e.value == this);
}
