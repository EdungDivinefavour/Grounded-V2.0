import 'dart:math';
import 'package:grounded/constants/enums/math_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/models/question/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'math.g.dart';

@JsonSerializable(explicitToJson: true)
class Math extends Question {
  @override
  final SubjectType subjectType;
  @override
  final MathType mathType;

  Math({required this.mathType, this.subjectType = SubjectType.maths})
      : super(subjectType: subjectType, mathType: mathType);

  static Math regularMath(MathType mathType) {
    final math = Math(mathType: mathType);

    final num1 = Random().nextInt(10) + 1;
    final num2 = Random().nextInt(10) + 1;

    if (math.mathType == MathType.addition) {
      math.correctAnswer = "${num1 + num2}";
      math.displayedQuestion = "$num1 + $num2";
    } else if (math.mathType == MathType.subtraction) {
      math.correctAnswer = "${num1 - num2}";
      math.displayedQuestion = "$num1 - $num2";
    } else if (math.mathType == MathType.multiplication) {
      math.correctAnswer = "${num1 * num2}";
      math.displayedQuestion = "$num1 x $num2";
    } else if (math.mathType == MathType.division) {
      math.correctAnswer = "${num1 / num2}";
      math.displayedQuestion = "$num1 ÷ $num2";
    }

    return math;
  }

  static Math findMissingNumberMath(MathType mathType) {
    final math = Math(mathType: mathType);

    final num1 = Random().nextInt(10) + 1;
    final num2 = Random().nextInt(10) + 1;

    if (math.mathType == MathType.addition) {
      final result = num1 + num2;
      math.displayedQuestion = "$num1 + ? = $result";
      math.correctAnswer = "${result - num1}";
    } else if (math.mathType == MathType.subtraction) {
      final result = num1 - num2;
      math.displayedQuestion = "$num1 - ? = $result";
      math.correctAnswer = "${result + num1}";
    } else if (math.mathType == MathType.multiplication) {
      final result = num1 * num2;
      math.displayedQuestion = "$num1 x ? = $result";
      math.correctAnswer = "${result / num1}";
    } else if (math.mathType == MathType.division) {
      final result = num1 / num2;
      math.displayedQuestion = "$num1 + ? = $result";
      math.correctAnswer = "${result * num1}";
    }

    return math;
  }

  factory Math.fromJson(Map<String, dynamic> json) => _$MathFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MathToJson(this);
}
