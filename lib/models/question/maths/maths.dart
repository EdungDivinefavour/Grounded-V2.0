import 'package:grounded/constants/enums/question_type.dart';
import 'package:grounded/models/question/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'maths.g.dart';

@JsonSerializable(explicitToJson: true)
class Maths extends Question {
  Maths() : super(questionType: QuestionType.maths);
}
