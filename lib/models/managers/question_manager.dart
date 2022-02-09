import 'package:grounded/models/grounded_task.dart';
import 'package:grounded/models/question/english/english.dart';
import 'package:grounded/models/question/math/math.dart';

class QuestionManager {
  QuestionManager._();
  static final QuestionManager _instance = QuestionManager._();
  static QuestionManager get instance => _instance;

  void buildMathList(GroundedTask task) {
    for (int i = 0; i < 6; i++) {
      task.questions.add(Math.regularMath(task.mathTypeToCreate!));
    }
    for (int i = 0; i < 4; i++) {
      task.questions.add(Math.findMissingNumberMath(task.mathTypeToCreate!));
    }

    task.questions.shuffle();
  }

  void buildEnglishList(GroundedTask task) {
    for (int i = 0; i < 10; i++) {
      task.questions.add(English.regularEnglish());
    }
  }
}
