import 'dart:math';

import 'package:grounded/constants/enums/english_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
import 'package:grounded/constants/enums/word_type.dart';
import 'package:grounded/models/question/english/word/word.dart';
import 'package:grounded/models/question/question.dart';
import 'package:json_annotation/json_annotation.dart';

part 'english.g.dart';

const allLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

@JsonSerializable(explicitToJson: true)
class English extends Question {
  @override
  final SubjectType subjectType;
  @override
  final EnglishType englishType;
  Word word;
  List<String> suggestedAnswers;

  English({
    required this.word,
    required this.suggestedAnswers,
    this.subjectType = SubjectType.english,
    this.englishType = EnglishType.general,
  }) : super(
          subjectType: subjectType,
          englishType: englishType,
        );

  static English regularEnglish() {
    final r = Random();
    final english = English(
        word: Word(
            text: "nebucadnezir",
            wordType: WordType.household,
            imageUrl: "https://"),
        suggestedAnswers: []);

    final randomIndex = r.nextInt(english.word.text.length - 1) + 1;
    english.correctAnswer = english.word.text[randomIndex];
    english.displayedQuestion =
        english.word.text.replaceFirst(RegExp(english.correctAnswer!), '_');

    // Setup suggestions
    english.suggestedAnswers.add(english.correctAnswer!);
    // Remove correct answer from allAlphabets array
    final chars = allLetters.replaceFirst(RegExp(english.correctAnswer!), '');

    for (int i = 0; i < 3; i++) {
      final letter =
          List.generate(1, (index) => chars[r.nextInt(chars.length)]).join();
      english.suggestedAnswers.add(letter);
    }
    english.suggestedAnswers.shuffle();

    return english;
  }

  factory English.fromJson(Map<String, dynamic> json) =>
      _$EnglishFromJson(json);
  Map<String, dynamic> toJson() => _$EnglishToJson(this);
}
