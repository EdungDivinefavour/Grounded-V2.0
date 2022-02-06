import 'package:grounded/constants/enums/question_category.dart';
import 'package:grounded/constants/enums/question_type.dart';
import 'package:grounded/models/question_manager.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  final QuestionCategory questionCategory;
  final QuestionType questionType;
  final bool hasBeenAnswered;
  String? displayedQuestion;
  String? pickedAnswer;
  String? correctAnswer;

  Question({
    required this.questionCategory,
    required this.questionType,
    this.hasBeenAnswered = false,
    this.displayedQuestion,
    this.pickedAnswer,
    this.correctAnswer,
  });

  static Question newQuestion(
    QuestionCategory questionCategory,
    QuestionType questionType,
  ) {
    final newQuestion = Question(
      questionCategory: questionCategory,
      questionType: questionType,
    );

    QuestionManager.instance.buildMath(newQuestion);
    return newQuestion;
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
