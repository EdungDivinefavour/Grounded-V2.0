import 'dart:math';

import 'package:grounded/constants/enums/english_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
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
  String? displayedQuestion;
  @override
  String? pickedAnswer;
  @override
  String? correctAnswer;
  @override
  int? completedTimestamp;
  @override
  final EnglishType? englishType;
  @override
  List<String>? suggestedAnswers;
  @override
  Word? word;

  English({
    required this.word,
    required this.suggestedAnswers,
    this.subjectType = SubjectType.english,
    this.englishType = EnglishType.general,
    this.displayedQuestion,
    this.pickedAnswer,
    this.completedTimestamp,
  }) : super(
          subjectType: subjectType,
          englishType: englishType,
          displayedQuestion: displayedQuestion,
          pickedAnswer: pickedAnswer,
          correctAnswer: pickedAnswer,
          completedTimestamp: completedTimestamp,
          suggestedAnswers: suggestedAnswers,
          word: word,
        );

  static English regularEnglish(Word word) {
    final r = Random();
    final english = English(word: word, suggestedAnswers: []);

    final randomIndex = r.nextInt(english.word!.text.length - 1) + 1;
    english.correctAnswer = english.word!.text[randomIndex];

    // Replace all names that have _ with space and then replace the correct answer with _
    english.displayedQuestion =
        english.word!.text.replaceFirst(RegExp('_'), ' ');
    english.displayedQuestion =
        english.word!.text.replaceFirst(RegExp(english.correctAnswer!), '_');

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

  factory English.fromJson(Map<String, dynamic> json) =>
      _$EnglishFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EnglishToJson(this);
}
