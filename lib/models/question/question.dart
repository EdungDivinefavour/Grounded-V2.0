import 'package:grounded/constants/enums/english_sub_type.dart';
import 'package:grounded/constants/enums/english_type.dart';
import 'package:grounded/constants/enums/math_sub_type.dart';
import 'package:grounded/constants/enums/math_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  final SubjectType subjectType;

  final MathType? mathType;
  final MathSubType? mathSubType;

  final EnglishType? englishType;
  final EnglishSubType? englishSubType;

  String? displayedQuestion;
  String? pickedAnswer;
  String? correctAnswer;
  int? completedTimestamp;
  List<String>? suggestedAnswers;
  String? word;
  int timeSpentOnQuestion;

  bool hasBeenAnswered;

  bool get wasAnsweredCorrectly => pickedAnswer == correctAnswer;

  Question({
    required this.subjectType,
    this.hasBeenAnswered = false,
    this.displayedQuestion,
    this.suggestedAnswers,
    this.pickedAnswer,
    this.correctAnswer,
    this.completedTimestamp,
    this.mathType,
    this.mathSubType,
    this.englishType,
    this.englishSubType,
    this.word,
    this.timeSpentOnQuestion = 0,
  });

  void setHasBeenAnswered() {
    hasBeenAnswered = pickedAnswer != null;
    completedTimestamp = DateTime.now().millisecondsSinceEpoch;
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
