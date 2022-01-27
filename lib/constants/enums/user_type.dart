import 'package:flutter/foundation.dart';

enum UserType { parent, child }

extension UserTypeExtension on UserType {
  String get value => describeEnum(this);
}

extension UserTypeExtensionStringExtension on String {
  UserType get toUserType => UserType.values.firstWhere((e) => e.value == this);
}
