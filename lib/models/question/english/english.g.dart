// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'english.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

English _$EnglishFromJson(Map<String, dynamic> json) => English(
      word: Word.fromJson(json['word'] as Map<String, dynamic>),
      suggestedAnswers: (json['suggestedAnswers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      subjectType:
          $enumDecodeNullable(_$SubjectTypeEnumMap, json['subjectType']) ??
              SubjectType.english,
      englishType:
          $enumDecodeNullable(_$EnglishTypeEnumMap, json['englishType']) ??
              EnglishType.general,
    )
      ..displayedQuestion = json['displayedQuestion'] as String?
      ..pickedAnswer = json['pickedAnswer'] as String?
      ..correctAnswer = json['correctAnswer'] as String?
      ..completedTimestamp = json['completedTimestamp'] as int?
      ..hasBeenAnswered = json['hasBeenAnswered'] as bool;

Map<String, dynamic> _$EnglishToJson(English instance) => <String, dynamic>{
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'completedTimestamp': instance.completedTimestamp,
      'hasBeenAnswered': instance.hasBeenAnswered,
      'subjectType': _$SubjectTypeEnumMap[instance.subjectType],
      'englishType': _$EnglishTypeEnumMap[instance.englishType],
      'word': instance.word.toJson(),
      'suggestedAnswers': instance.suggestedAnswers,
    };

const _$SubjectTypeEnumMap = {
  SubjectType.maths: 'maths',
  SubjectType.english: 'english',
};

const _$EnglishTypeEnumMap = {
  EnglishType.general: 'general',
};
