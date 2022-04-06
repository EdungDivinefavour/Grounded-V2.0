import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:grounded/styles/colors/theme_colors.dart';

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

  IconData get icon {
    if (this == MathType.addition) {
      return Icons.add_circle;
    } else if (this == MathType.subtraction) {
      return Icons.remove_circle;
    } else if (this == MathType.multiplication) {
      return Icons.cancel_outlined;
    } else {
      return TablerIcons.divide;
    }
  }

  Color get color {
    if (this == MathType.addition) {
      return ThemeColors.primary;
    } else if (this == MathType.subtraction) {
      return ThemeColors.darkElement;
    } else if (this == MathType.multiplication) {
      return ThemeColors.error;
    } else {
      return ThemeColors.primaryDark;
    }
  }
}

extension MathTypeExtensionStringExtension on String {
  MathType get toMathType =>
      MathType.values.firstWhere((e) => e.value.toLowerCase() == toLowerCase());
}
