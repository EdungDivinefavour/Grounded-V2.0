import 'package:grounded/constants/enums/question_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  final QuestionCategory questionCategory;
  String? displayedQuestion;
  String? pickedAnswer;
  String? correctAnswer;

  bool get hasBeenAnswered => pickedAnswer != null;

  Question({
    required this.questionCategory,
    this.displayedQuestion,
    this.pickedAnswer,
    this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
