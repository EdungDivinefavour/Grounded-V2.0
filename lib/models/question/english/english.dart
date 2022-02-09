import 'dart:math';

import 'package:grounded/constants/enums/question_category.dart';
import 'package:grounded/constants/enums/word_type.dart';
import 'package:grounded/models/question/english/word/word.dart';
import 'package:grounded/models/question/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'english.g.dart';

@JsonSerializable(explicitToJson: true)
class English extends Question {
  Word word;

  English({required this.word})
      : super(questionCategory: QuestionCategory.english);

  static English regularEnglish() {
    final english = English(
        word: Word(
            text: "nebucadnezir",
            wordType: WordType.household,
            imageUrl: "https://"));

    // Picks a random index
    final randomIndex = Random().nextInt(english.word.text.length - 1) + 1;

    // Sets the correct answer to be the char at that index
    english.correctAnswer = english.word.text[randomIndex];

    // Masks the initial word with an _ and sets it to the displayed question
    english.displayedQuestion =
        english.word.text.replaceFirst(RegExp(english.correctAnswer!), '_');

    return english;
  }

  factory English.fromJson(Map<String, dynamic> json) =>
      _$EnglishFromJson(json);
  Map<String, dynamic> toJson() => _$EnglishToJson(this);
}
