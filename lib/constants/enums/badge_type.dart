import 'package:flutter/foundation.dart';

enum BadgeType { champion, learner, expert, student, veteran }

extension BadgeTypeExtension on BadgeType {
  String get value => describeEnum(this);
}

extension BadgeTypeStringExtension on String {
  BadgeType get toBadgeType =>
      BadgeType.values.firstWhere((e) => e.value == this);
}
