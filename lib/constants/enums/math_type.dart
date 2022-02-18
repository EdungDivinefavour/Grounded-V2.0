import 'package:flutter/foundation.dart';

enum MathType {
  addition,
  subtraction,
  multiplication,
  division,
}

extension MathTypeExtension on MathType {
  String get stringValue => describeEnum(this);

  String get value =>
      "${stringValue[0].toUpperCase()}${stringValue.substring(1).toLowerCase()}";
}

extension MathTypeExtensionStringExtension on String {
  MathType get toMathType =>
      MathType.values.firstWhere((e) => e.value.toLowerCase() == toLowerCase());
}
