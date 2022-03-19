// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Math _$MathFromJson(Map<String, dynamic> json) => Math(
      mathType: $enumDecode(_$MathTypeEnumMap, json['mathType']),
      mathSubType: $enumDecode(_$MathSubTypeEnumMap, json['mathSubType']),
      subjectType:
          $enumDecodeNullable(_$SubjectTypeEnumMap, json['subjectType']) ??
              SubjectType.maths,
      displayedQuestion: json['displayedQuestion'] as String?,
      pickedAnswer: json['pickedAnswer'] as String?,
      completedTimestamp: json['completedTimestamp'] as int?,
    )
      ..suggestedAnswers = (json['suggestedAnswers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..word = json['word'] as String?
      ..timeSpentOnQuestion = json['timeSpentOnQuestion'] as int
      ..hasBeenAnswered = json['hasBeenAnswered'] as bool
      ..correctAnswer = json['correctAnswer'] as String?;

Map<String, dynamic> _$MathToJson(Math instance) => <String, dynamic>{
      'suggestedAnswers': instance.suggestedAnswers,
      'word': instance.word,
      'timeSpentOnQuestion': instance.timeSpentOnQuestion,
      'hasBeenAnswered': instance.hasBeenAnswered,
      'subjectType': _$SubjectTypeEnumMap[instance.subjectType],
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'completedTimestamp': instance.completedTimestamp,
      'mathType': _$MathTypeEnumMap[instance.mathType],
      'mathSubType': _$MathSubTypeEnumMap[instance.mathSubType],
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

const _$SubjectTypeEnumMap = {
  SubjectType.maths: 'maths',
  SubjectType.english: 'english',
};
