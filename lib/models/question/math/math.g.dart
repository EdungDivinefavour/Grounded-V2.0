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
    )
      ..displayedQuestion = json['displayedQuestion'] as String?
      ..pickedAnswer = json['pickedAnswer'] as String?
      ..correctAnswer = json['correctAnswer'] as String?
      ..completedTimestap = json['completedTimestap'] as int?
      ..hasBeenAnswered = json['hasBeenAnswered'] as bool;

Map<String, dynamic> _$MathToJson(Math instance) => <String, dynamic>{
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'completedTimestap': instance.completedTimestap,
      'hasBeenAnswered': instance.hasBeenAnswered,
      'subjectType': _$SubjectTypeEnumMap[instance.subjectType],
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
