import 'package:grounded/constants/enums/english_sub_type.dart';
import 'package:grounded/constants/enums/english_type.dart';
import 'package:grounded/constants/enums/subject_type.dart';
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
  List<String>? suggestedAnswers;
  @override
  String? word;
  @override
  final EnglishType englishType;
  @override
  final EnglishSubType englishSubType;

  English({
    required this.word,
    required this.suggestedAnswers,
    this.englishType = EnglishType.general,
    required this.englishSubType,
    this.subjectType = SubjectType.english,
    this.displayedQuestion,
    this.pickedAnswer,
    this.completedTimestamp,
  }) : super(
          subjectType: subjectType,
          englishType: englishType,
          englishSubType: englishSubType,
          displayedQuestion: displayedQuestion,
          pickedAnswer: pickedAnswer,
          correctAnswer: pickedAnswer,
          completedTimestamp: completedTimestamp,
          suggestedAnswers: suggestedAnswers,
          word: word,
        );

  factory English.fromJson(Map<String, dynamic> json) =>
      _$EnglishFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EnglishToJson(this);
}
