// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'english.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

English _$EnglishFromJson(Map<String, dynamic> json) => English(
      word: json['word'] == null
          ? null
          : Word.fromJson(json['word'] as Map<String, dynamic>),
      suggestedAnswers: (json['suggestedAnswers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subjectType:
          $enumDecodeNullable(_$SubjectTypeEnumMap, json['subjectType']) ??
              SubjectType.english,
      englishType:
          $enumDecodeNullable(_$EnglishTypeEnumMap, json['englishType']) ??
              EnglishType.general,
      displayedQuestion: json['displayedQuestion'] as String?,
      pickedAnswer: json['pickedAnswer'] as String?,
      completedTimestamp: json['completedTimestamp'] as int?,
    )
      ..timeSpentOnQuestion = json['timeSpentOnQuestion'] as int?
      ..hasBeenAnswered = json['hasBeenAnswered'] as bool
      ..correctAnswer = json['correctAnswer'] as String?;

Map<String, dynamic> _$EnglishToJson(English instance) => <String, dynamic>{
      'timeSpentOnQuestion': instance.timeSpentOnQuestion,
      'hasBeenAnswered': instance.hasBeenAnswered,
      'subjectType': _$SubjectTypeEnumMap[instance.subjectType],
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'completedTimestamp': instance.completedTimestamp,
      'englishType': _$EnglishTypeEnumMap[instance.englishType],
      'suggestedAnswers': instance.suggestedAnswers,
      'word': instance.word?.toJson(),
    };

const _$SubjectTypeEnumMap = {
  SubjectType.maths: 'maths',
  SubjectType.english: 'english',
};

const _$EnglishTypeEnumMap = {
  EnglishType.general: 'general',
};
