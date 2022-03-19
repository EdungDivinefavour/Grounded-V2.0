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
  place,
  vehicle,
  household,
  thing,
  person
}

extension WordTypeExtension on WordType {
  String get stringValue => describeEnum(this);

  String get value =>
      "${stringValue[0].toUpperCase()}${stringValue.substring(1).toLowerCase()}";
}

extension WordTypeExtensionStringExtension on String {
  WordType get toWordType =>
      WordType.values.firstWhere((e) => e.value.toLowerCase() == toLowerCase());
}
