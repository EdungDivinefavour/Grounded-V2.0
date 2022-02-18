import 'package:grounded/constants/enums/subject_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  final SubjectType subject;
  String? displayedQuestion;
  String? pickedAnswer;
  String? correctAnswer;
  int? completedTimestap;

  bool get hasBeenAnswered => pickedAnswer != null;

  Question({
    required this.subject,
    this.displayedQuestion,
    this.pickedAnswer,
    this.correctAnswer,
    this.completedTimestap,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
