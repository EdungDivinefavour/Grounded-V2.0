// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'english.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

English _$EnglishFromJson(Map<String, dynamic> json) => English(
      word: json['word'] as String?,
      suggestedAnswers: (json['suggestedAnswers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      englishType:
          $enumDecodeNullable(_$EnglishTypeEnumMap, json['englishType']) ??
              EnglishType.general,
      englishSubType:
          $enumDecode(_$EnglishSubTypeEnumMap, json['englishSubType']),
      subjectType:
          $enumDecodeNullable(_$SubjectTypeEnumMap, json['subjectType']) ??
              SubjectType.english,
      displayedQuestion: json['displayedQuestion'] as String?,
      pickedAnswer: json['pickedAnswer'] as String?,
      completedTimestamp: json['completedTimestamp'] as int?,
    )
      ..timeSpentOnQuestion = json['timeSpentOnQuestion'] as int
      ..numberOfTimesAttempted = json['numberOfTimesAttempted'] as int
      ..hasBeenAnswered = json['hasBeenAnswered'] as bool
      ..correctAnswer = json['correctAnswer'] as String?;

Map<String, dynamic> _$EnglishToJson(English instance) => <String, dynamic>{
      'timeSpentOnQuestion': instance.timeSpentOnQuestion,
      'numberOfTimesAttempted': instance.numberOfTimesAttempted,
      'hasBeenAnswered': instance.hasBeenAnswered,
      'subjectType': _$SubjectTypeEnumMap[instance.subjectType],
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'completedTimestamp': instance.completedTimestamp,
      'suggestedAnswers': instance.suggestedAnswers,
      'word': instance.word,
      'englishType': _$EnglishTypeEnumMap[instance.englishType],
      'englishSubType': _$EnglishSubTypeEnumMap[instance.englishSubType],
    };

const _$EnglishTypeEnumMap = {
  EnglishType.general: 'general',
};

const _$EnglishSubTypeEnumMap = {
  EnglishSubType.animal: 'animal',
  EnglishSubType.music: 'music',
  EnglishSubType.sport: 'sport',
  EnglishSubType.color: 'color',
  EnglishSubType.number: 'number',
  EnglishSubType.food: 'food',
  EnglishSubType.nature: 'nature',
  EnglishSubType.climate: 'climate',
  EnglishSubType.fruits: 'fruits',
  EnglishSubType.place: 'place',
  EnglishSubType.vehicle: 'vehicle',
  EnglishSubType.household: 'household',
  EnglishSubType.thing: 'thing',
  EnglishSubType.person: 'person',
};

const _$SubjectTypeEnumMap = {
  SubjectType.maths: 'maths',
  SubjectType.english: 'english',
};
