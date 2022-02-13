import 'package:flutter/foundation.dart';

enum QuestionType { maths, english }

extension QuestionTypeExtension on QuestionType {
  String get value => describeEnum(this);
}

extension QuestionTypeExtensionStringExtension on String {
  QuestionType get toQuestionType =>
      QuestionType.values.firstWhere((e) => e.value == this);
}
