import 'dart:math';

import 'package:grounded/constants/enums/english_sub_type.dart';
import 'package:grounded/models/managers/question_manager.dart';
import 'package:grounded/models/question/english/english.dart';

extension QuestionManagerEnglishExtension on QuestionManager {
  English newEnglish(String word, EnglishSubType englishSubType) {
    final r = Random();
    final english = English(
        word: word, suggestedAnswers: [], englishSubType: englishSubType);

    final randomIndex = r.nextInt(english.word!.length - 1) + 1;
    english.correctAnswer = english.word![randomIndex];

    // Replace all names that have _ with space and then replace the correct answer with _
    english.displayedQuestion = english.word!.replaceFirst(RegExp('_'), ' ');
    english.displayedQuestion =
        english.word!.replaceFirst(RegExp(english.correctAnswer!), '_');

    // Setup suggestions
    english.suggestedAnswers?.add(english.correctAnswer!);
    // Remove correct answer from allAlphabets array
    final chars = allLetters.replaceFirst(RegExp(english.correctAnswer!), '');

    for (int i = 0; i < 3; i++) {
      final letter =
          List.generate(1, (index) => chars[r.nextInt(chars.length)]).join();
      english.suggestedAnswers?.add(letter);
    }
    english.suggestedAnswers?.shuffle();

    return english;
  }
}
