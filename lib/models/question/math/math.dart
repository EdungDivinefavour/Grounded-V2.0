import 'dart:math';
import 'package:grounded/constants/enums/math_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/models/question/question.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:grounded/models/question/english/word/word.dart';

part 'math.g.dart';

@JsonSerializable(explicitToJson: true)
class Math extends Question {
  @override
  final SubjectType subjectType;
  @override
  String? displayedQuestion;
  @override
  String? pickedAnswer;
  @override
  String? correctAnswer;
  @override
  int? completedTimestamp;
  @override
  final MathType mathType;

  Math({
    required this.mathType,
    this.subjectType = SubjectType.maths,
    this.displayedQuestion,
    this.pickedAnswer,
    this.completedTimestamp,
  }) : super(
          subjectType: subjectType,
          mathType: mathType,
          displayedQuestion: displayedQuestion,
          pickedAnswer: pickedAnswer,
          correctAnswer: pickedAnswer,
          completedTimestamp: completedTimestamp,
        );

  static Math regularMath(MathType mathType) {
    final math = Math(mathType: mathType);

    if (math.mathType == MathType.addition) {
      final num1 = Random().nextInt(10) + 1;
      final num2 = Random().nextInt(10) + 1;

      math.correctAnswer = "${num1 + num2}";
      math.displayedQuestion = "$num1 + $num2";
    } else if (math.mathType == MathType.subtraction) {
      final num1 = Random().nextInt(25) + 1;
      final num2 = Random().nextInt(num1) + 1;

      math.correctAnswer = "${num1 - num2}";
      math.displayedQuestion = "$num1 - $num2";
    } else if (math.mathType == MathType.multiplication) {
      final num1 = Random().nextInt(10) + 1;
      final num2 = Random().nextInt(10) + 1;

      math.correctAnswer = "${num1 * num2}";
      math.displayedQuestion = "$num1 x $num2";
    } else if (math.mathType == MathType.division) {
      final num1 = Random().nextInt(10) + 1;
      final num2 = Random().nextInt(10) + 1;
      final result = num1 * num2;

      math.correctAnswer = "${result ~/ num1}";
      math.displayedQuestion = "$result ÷ $num1";
    }

    return math;
  }

  static Math findMissingNumberMath(MathType mathType) {
    final math = Math(mathType: mathType);

    if (math.mathType == MathType.addition) {
      final num1 = Random().nextInt(10) + 1;
      final num2 = Random().nextInt(10) + 1;
      final result = num1 + num2;

      math.displayedQuestion = "$num1 + ? = $result";
      math.correctAnswer = "$num2";
    } else if (math.mathType == MathType.subtraction) {
      final num1 = Random().nextInt(25) + 1;
      final num2 = Random().nextInt(num1) + 1;
      final result = num1 - num2;

      math.displayedQuestion = "$num1 - ? = $result";
      math.correctAnswer = "$num2";
    } else if (math.mathType == MathType.multiplication) {
      final num1 = Random().nextInt(10) + 1;
      final num2 = Random().nextInt(10) + 1;
      final result = num1 * num2;

      math.displayedQuestion = "$num1 x ? = $result";
      math.correctAnswer = "$num2";
    } else if (math.mathType == MathType.division) {
      final num1 = Random().nextInt(10) + 1;
      final num2 = Random().nextInt(10) + 1;
      final result = num1 * num2;

      math.displayedQuestion = "$result + ? = $num1";
      math.correctAnswer = "$num2";
    }

    return math;
  }

  factory Math.fromJson(Map<String, dynamic> json) => _$MathFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MathToJson(this);
}
