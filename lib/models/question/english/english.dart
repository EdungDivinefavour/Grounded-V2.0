import 'package:grounded/constants/enums/question_type.dart';
import 'package:grounded/models/question/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'english.g.dart';

@JsonSerializable(explicitToJson: true)
class English extends Question {
  English() : super(questionType: QuestionType.english);
}
