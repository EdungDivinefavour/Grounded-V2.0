import 'package:flutter/foundation.dart';

enum QuestionCategory { maths, english }

extension QuestionCategoryExtension on QuestionCategory {
  String get value => describeEnum(this);
}

extension QuestionCategoryExtensionStringExtension on String {
  QuestionCategory get toQuestionCategory =>
      QuestionCategory.values.firstWhere((e) => e.value == this);
}
