import 'package:grounded/constants/enums/english_type.dart';
import 'package:grounded/constants/enums/math_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  final SubjectType subjectType;
  final MathType? mathType;
  final EnglishType? englishType;
  String? displayedQuestion;
  String? pickedAnswer;
  String? correctAnswer;
  int? completedTimestap;

  bool get hasBeenAnswered => pickedAnswer != null;

  Question({
    required this.subjectType,
    this.displayedQuestion,
    this.pickedAnswer,
    this.correctAnswer,
    this.completedTimestap,
    this.mathType,
    this.englishType,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
