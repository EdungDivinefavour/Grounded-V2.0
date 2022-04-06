import 'dart:math';

import 'package:grounded/constants/enums/math_sub_type.dart';
import 'package:grounded/constants/enums/math_type.dart';
import 'package:grounded/models/managers/question_manager.dart';
import 'package:grounded/models/question/math/math.dart';

extension QuestionManagerMathExtension on QuestionManager {
  Math newMath(MathType mathType, MathSubType mathSubType,
      {required int questionIndex}) {
    if (mathSubType == MathSubType.addDoubles) {
      return _addDoubles(mathType, mathSubType);
    } else if (mathSubType == MathSubType.addTwoNumbersMakeTen) {
      return _addTwoNumbersMakeTen(mathType, mathSubType);
    } else if (mathSubType == MathSubType.addThreeNumbers) {
      return _addThreeNumbers(mathType, mathSubType);
    } else if (mathSubType == MathSubType.subtractDoubles) {
      return _subtractDoubles(mathType, mathSubType);
    } else if (mathSubType == MathSubType.divideDoubles) {
      return _divideDoubles(mathType, mathSubType);
    } else if (mathSubType == MathSubType.findMissingNumber) {
      return _findMissingNumberMath(mathType, mathSubType);
    } else {
      return _multiplyNumbers(mathType, mathSubType, questionIndex);
    }
  }

  // GENERAL MATHS
  Math _generalMath(MathType mathType, MathSubType mathSubType) {
    final math = Math(mathType: mathType, mathSubType: mathSubType);

    if (math.mathType == MathType.addition) {
      final num1 = Random().nextInt(100) + 1;
      final num2 = Random().nextInt(100) + 1;

      math.correctAnswer = "${num1 + num2}";
      math.displayedQuestion = "$num1 + $num2";
    } else if (math.mathType == MathType.subtraction) {
      final num1 = Random().nextInt(80) + 10;
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

  Math _findMissingNumberMath(MathType mathType, MathSubType mathSubType) {
    final math = Math(mathType: mathType, mathSubType: mathSubType);

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

  // ADDITION SPECIFIC MATHS
  Math _addDoubles(MathType mathType, MathSubType mathSubType) {
    return _generalMath(mathType, mathSubType);
  }

  Math _addTwoNumbersMakeTen(MathType mathType, MathSubType mathSubType) {
    final math = Math(mathType: mathType, mathSubType: mathSubType);

    final num1 = Random().nextInt(10) + 1;
    final num2 = 10 - num1;

    math.correctAnswer = "$num2";
    math.displayedQuestion = "$num1 + ? = 10";

    return math;
  }

  Math _addThreeNumbers(MathType mathType, MathSubType mathSubType) {
    final math = Math(mathType: mathType, mathSubType: mathSubType);

    final num1 = Random().nextInt(10) + 1;
    final num2 = Random().nextInt(10) + 1;
    final num3 = Random().nextInt(10) + 1;

    math.correctAnswer = "${num1 + num2 + num3}";
    math.displayedQuestion = "$num1 + $num2 + $num3";

    return math;
  }

  // SUBTRACTION SPECIFIC MATHS
  Math _subtractDoubles(MathType mathType, MathSubType mathSubType) {
    return _generalMath(mathType, mathSubType);
  }

  // DIVISION SPECIFIC MATHS
  Math _divideDoubles(MathType mathType, MathSubType mathSubType) {
    return _generalMath(mathType, mathSubType);
  }

  // MULTIPLICATION SPECIFIC MATHS
  Math _multiplyNumbers(
      MathType mathType, MathSubType mathSubType, int questionIndex) {
    final math = Math(mathType: mathType, mathSubType: mathSubType);

    final mathSubTypeStringValue =
        mathSubType.value.replaceFirst(RegExp(" x"), '');

    final num1 = int.parse(mathSubTypeStringValue);
    final num2 = questionIndex + 1;

    math.correctAnswer = "${num1 * num2}";
    math.displayedQuestion = "$num1 x $num2";
    return math;
  }
}
