// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      subjectType: $enumDecode(_$SubjectTypeEnumMap, json['subjectType']),
      hasBeenAnswered: json['hasBeenAnswered'] as bool? ?? false,
      displayedQuestion: json['displayedQuestion'] as String?,
      pickedAnswer: json['pickedAnswer'] as String?,
      correctAnswer: json['correctAnswer'] as String?,
      completedTimestap: json['completedTimestap'] as int?,
      mathType: $enumDecodeNullable(_$MathTypeEnumMap, json['mathType']),
      englishType:
          $enumDecodeNullable(_$EnglishTypeEnumMap, json['englishType']),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'subjectType': _$SubjectTypeEnumMap[instance.subjectType],
      'mathType': _$MathTypeEnumMap[instance.mathType],
      'englishType': _$EnglishTypeEnumMap[instance.englishType],
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'completedTimestap': instance.completedTimestap,
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

const _$EnglishTypeEnumMap = {
  EnglishType.general: 'general',
};
