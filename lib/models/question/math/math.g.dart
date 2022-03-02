// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Math _$MathFromJson(Map<String, dynamic> json) => Math(
      mathType: $enumDecode(_$MathTypeEnumMap, json['mathType']),
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
      ..word = json['word'] == null
          ? null
          : Word.fromJson(json['word'] as Map<String, dynamic>)
      ..timeSpentOnQuestion = json['timeSpentOnQuestion'] as int?
      ..hasBeenAnswered = json['hasBeenAnswered'] as bool
      ..correctAnswer = json['correctAnswer'] as String?;

Map<String, dynamic> _$MathToJson(Math instance) => <String, dynamic>{
      'suggestedAnswers': instance.suggestedAnswers,
      'word': instance.word?.toJson(),
      'timeSpentOnQuestion': instance.timeSpentOnQuestion,
      'hasBeenAnswered': instance.hasBeenAnswered,
      'subjectType': _$SubjectTypeEnumMap[instance.subjectType],
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'completedTimestamp': instance.completedTimestamp,
      'mathType': _$MathTypeEnumMap[instance.mathType],
    };

const _$MathTypeEnumMap = {
  MathType.addition: 'addition',
  MathType.subtraction: 'subtraction',
  MathType.multiplication: 'multiplication',
  MathType.division: 'division',
};

const _$SubjectTypeEnumMap = {
  SubjectType.maths: 'maths',
  SubjectType.english: 'english',
};
