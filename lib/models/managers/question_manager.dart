import 'dart:math';

import 'package:grounded/constants/enums/math_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/extensions/question_manager_english_extension.dart';
import 'package:grounded/extensions/question_manager_math_extension.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/question/english/word/word.dart';
import 'package:grounded/services/local_asset/local_asset.dart';

class QuestionManager {
  QuestionManager._();
  static final QuestionManager _instance = QuestionManager._();
  static QuestionManager get instance => _instance;

  List<Word> _allWords = [];

  Future<void> init() async {
    LocalAsset.instance.readJSON("english_words.json").then((allwords) {
      final List<dynamic> jsonList = allwords;

      _allWords = List<Word>.from(jsonList.map((x) => Word.fromJson(x)));
    });
  }

  void buildQuestionsForTask(GroundedTask task, {int numberOfQuestions = 10}) {
    if (task.subjectType == SubjectType.maths) {
      _buildMathList(task, numberOfQuestions);
    } else {
      _buildEnglishList(task, numberOfQuestions);
    }
  }

  void _buildMathList(GroundedTask task, [int numberOfQuestions = 10]) {
    for (int i = 0; i < numberOfQuestions; i++) {
      task.questions.add(
        newMath(task.mathTypeToCreate!, task.mathSubTypeToCreate!,
            questionIndex: i),
      );
    }

    if (task.mathTypeToCreate == MathType.multiplication) return;
    task.questions.shuffle();
  }

  void _buildEnglishList(GroundedTask task, [int numberOfQuestions = 10]) {
    final r = Random();
    final wordArrayToUse =
        _allWords.where((x) => x.type == task.englishSubTypeToCreate).toList();

    for (int i = 0; i < numberOfQuestions; i++) {
      var word = wordArrayToUse[r.nextInt(wordArrayToUse.length)];
      word.text = word.text.toUpperCase();

      task.questions.add(newEnglish(word.text, task.englishSubTypeToCreate!));
    }
  }
}
