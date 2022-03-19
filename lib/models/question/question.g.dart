// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      subjectType: $enumDecode(_$SubjectTypeEnumMap, json['subjectType']),
      hasBeenAnswered: json['hasBeenAnswered'] as bool? ?? false,
      displayedQuestion: json['displayedQuestion'] as String?,
      suggestedAnswers: (json['suggestedAnswers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      pickedAnswer: json['pickedAnswer'] as String?,
      correctAnswer: json['correctAnswer'] as String?,
      completedTimestamp: json['completedTimestamp'] as int?,
      mathType: $enumDecodeNullable(_$MathTypeEnumMap, json['mathType']),
      mathSubType:
          $enumDecodeNullable(_$MathSubTypeEnumMap, json['mathSubType']),
      englishType:
          $enumDecodeNullable(_$EnglishTypeEnumMap, json['englishType']),
      englishSubType:
          $enumDecodeNullable(_$EnglishSubTypeEnumMap, json['englishSubType']),
      word: json['word'] as String?,
      timeSpentOnQuestion: json['timeSpentOnQuestion'] as int? ?? 0,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'subjectType': _$SubjectTypeEnumMap[instance.subjectType],
      'mathType': _$MathTypeEnumMap[instance.mathType],
      'mathSubType': _$MathSubTypeEnumMap[instance.mathSubType],
      'englishType': _$EnglishTypeEnumMap[instance.englishType],
      'englishSubType': _$EnglishSubTypeEnumMap[instance.englishSubType],
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'completedTimestamp': instance.completedTimestamp,
      'suggestedAnswers': instance.suggestedAnswers,
      'word': instance.word,
      'timeSpentOnQuestion': instance.timeSpentOnQuestion,
      'hasBeenAnswered': instance.hasBeenAnswered,
    };

const _$SubjectTypeEnumMap = {
  SubjectType.maths: 'maths',
  SubjectType.english: 'english',
};

const _$MathTypeEnumMap = {
  MathType.addition: 'addition',
  MathType.subtraction: 'subtraction',
  MathType.multiplication: 'multiplication',
  MathType.division: 'division',
};

const _$MathSubTypeEnumMap = {
  MathSubType.addDoubles: 'addDoubles',
  MathSubType.addTwoNumbersMakeTen: 'addTwoNumbersMakeTen',
  MathSubType.addThreeNumbers: 'addThreeNumbers',
  MathSubType.subtractDoubles: 'subtractDoubles',
  MathSubType.multiplyDoubles: 'multiplyDoubles',
  MathSubType.divideDoubles: 'divideDoubles',
  MathSubType.findMissingNumber: 'findMissingNumber',
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
