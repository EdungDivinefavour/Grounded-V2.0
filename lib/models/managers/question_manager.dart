import 'dart:math';

import 'package:grounded/extensions/question_manager_english_extension.dart';
import 'package:grounded/extensions/question_manager_math_extension.dart';
import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/question/english/word/word.dart';
import 'package:grounded/services/local_asset/local_asset.dart';

class QuestionManager {
  QuestionManager._();
  static final QuestionManager _instance = QuestionManager._();
  static QuestionManager get instance => _instance;

  List<Word> allWords = [];

  Future<void> init() async {
    LocalAsset.instance.readJSON("english_words.json").then((allwords) {
      final List<dynamic> jsonList = allwords;

      allWords = List<Word>.from(jsonList.map((x) => Word.fromJson(x)));
    });
  }

  void buildMathList(GroundedTask task) {
    for (int i = 0; i < 10; i++) {
      task.questions
          .add(newMath(task.mathTypeToCreate!, task.mathSubTypeToCreate!));
    }

    task.questions.shuffle();
  }

  void buildEnglishList(GroundedTask task) {
    final r = Random();
    final wordArrayToUse =
        allWords.where((x) => x.type == task.englishSubTypeToCreate).toList();

    for (int i = 0; i < 10; i++) {
      var word = wordArrayToUse[r.nextInt(wordArrayToUse.length)];
      word.text = word.text.toUpperCase();

      task.questions.add(newEnglish(word.text, task.englishSubTypeToCreate!));
    }
  }
}
