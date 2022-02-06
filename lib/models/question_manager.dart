import 'dart:math';

import 'package:grounded/constants/enums/question_type.dart';
import 'package:grounded/models/grounded_task.dart';
import 'package:grounded/models/question/question.dart';

class QuestionManager {
  QuestionManager._();
  static final QuestionManager _instance = QuestionManager._();
  static QuestionManager get instance => _instance;

  void buildMath(Question question) {
    final leftOperand = Random().nextInt(10) + 1;
    final rightOperand = Random().nextInt(10) + 1;

    if (question.questionType == QuestionType.addition) {
      question.displayedQuestion = "$leftOperand + $rightOperand";
      question.correctAnswer = "${leftOperand + rightOperand}";
    } else if (question.questionType == QuestionType.subtraction) {
      question.displayedQuestion = "$leftOperand - $rightOperand";
      question.correctAnswer = "${leftOperand - rightOperand}";
    } else if (question.questionType == QuestionType.multiplication) {
      question.displayedQuestion = "$leftOperand x $rightOperand";
      question.correctAnswer = "${leftOperand * rightOperand}";
    } else if (question.questionType == QuestionType.division) {
      question.displayedQuestion = "$leftOperand ÷ $rightOperand";
      question.correctAnswer = "${leftOperand / rightOperand}";
    }
  }

  void buildEnglish(Question question) {}

  List<Question> buildQuestionList(GroundedTask task) {
    final List<Question> questions = [];

    for (int i = 0; i < 10; i++) {
      questions.add(Question.newQuestion(
        task.questionCategoryToCreate,
        task.questionTypeToCreate,
      ));
    }
    return questions;
  }
}
