import 'package:flutter/foundation.dart';

enum WordType {
  animal,
  music,
  sport,
  color,
  number,
  food,
  nature,
  climate,
  fruits,
  country,
  vehicle,
  household,
  thing,
}

extension WordTypeExtension on WordType {
  String get value => describeEnum(this);
}

extension WordTypeExtensionStringExtension on String {
  WordType get toWordType => WordType.values.firstWhere((e) => e.value == this);
}
