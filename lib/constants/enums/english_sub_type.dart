import 'package:flutter/foundation.dart';

enum EnglishSubType {
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

extension EnglishSubTypeExtension on EnglishSubType {
  String get stringValue => describeEnum(this);

  String get value =>
      "${stringValue[0].toUpperCase()}${stringValue.substring(1).toLowerCase()}";
}

extension EnglishSubTypeExtensionStringExtension on String {
  EnglishSubType get toEnglishSubType => EnglishSubType.values
      .firstWhere((e) => e.value.toLowerCase() == toLowerCase());
}
