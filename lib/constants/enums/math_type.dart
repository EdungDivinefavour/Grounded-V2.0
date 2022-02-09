import 'package:flutter/foundation.dart';

enum MathType {
  addition,
  subtraction,
  multiplication,
  division,
}

extension MathTypeExtension on MathType {
  String get value => describeEnum(this);
}

extension MathTypeExtensionStringExtension on String {
  MathType get toMathType => MathType.values.firstWhere((e) => e.value == this);
}
