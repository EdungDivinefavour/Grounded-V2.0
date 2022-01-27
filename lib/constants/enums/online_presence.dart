import 'package:flutter/foundation.dart';

enum OnlinePresence { online, away, offline }

extension OnlinePresenceExtension on OnlinePresence {
  String get value => describeEnum(this);
}

extension OnlinePresenceExtensionStringExtension on String {
  OnlinePresence get toOnlinePresence =>
      OnlinePresence.values.firstWhere((e) => e.value == this);
}
