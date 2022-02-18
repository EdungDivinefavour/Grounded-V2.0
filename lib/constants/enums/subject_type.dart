import 'package:flutter/foundation.dart';

enum SubjectType { maths, english }

extension SubjectTypeExtension on SubjectType {
  String get stringValue => describeEnum(this);

  String get value =>
      "${stringValue[0].toUpperCase()}${stringValue.substring(1).toLowerCase()}";
}

extension SubjectTypeExtensionStringExtension on String {
  SubjectType get toSubjectType => SubjectType.values
      .firstWhere((e) => e.value.toLowerCase() == toLowerCase());
}
