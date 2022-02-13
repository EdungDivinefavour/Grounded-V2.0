import 'package:grounded/constants/enums/question_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true)
class Question {
  final QuestionType questionType;
  final bool hasBeenAnswered;

  Question({
    required this.questionType,
    this.hasBeenAnswered = false,
  });

  Question newEnglishQuestion() {
    return Question(questionType: QuestionType.english);
  }

  Question newMathsQuestion() {
    return Question(questionType: QuestionType.maths);
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
