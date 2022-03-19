import 'package:flutter/foundation.dart';

enum MathSubType {
  addDoubles,
  addTwoNumbersMakeTen,
  findMissingNumber,
  addThreeNumbers,
}

extension MathSubTypeExtension on MathSubType {
  String get stringValue => describeEnum(this);

  String get value =>
      "${stringValue[0].toUpperCase()}${stringValue.substring(1).toLowerCase()}";
}

extension MathSubTypeExtensionStringExtension on String {
  MathSubType get toMathSubType => MathSubType.values
      .firstWhere((e) => e.value.toLowerCase() == toLowerCase());
}
