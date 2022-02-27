import 'dart:math';

import 'package:grounded/models/grounded_task/grounded_task.dart';
import 'package:grounded/models/question/english/english.dart';
import 'package:grounded/models/question/english/word/word.dart';
import 'package:grounded/models/question/math/math.dart';
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
    for (int i = 0; i < 6; i++) {
      task.questions.add(Math.regularMath(task.mathTypeToCreate!));
    }
    for (int i = 0; i < 4; i++) {
      task.questions.add(Math.findMissingNumberMath(task.mathTypeToCreate!));
    }

    task.questions.shuffle();
  }

  void buildEnglishList(GroundedTask task) {
    final r = Random();

    for (int i = 0; i < 10; i++) {
      var word = allWords[r.nextInt(allWords.length)];
      word.text = word.text.toUpperCase();

      task.questions.add(English.regularEnglish(word));
    }
  }
}
