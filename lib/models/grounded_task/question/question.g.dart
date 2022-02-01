// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      questionType: $enumDecode(_$QuestionTypeEnumMap, json['questionType']),
      hasBeenAnswered: json['hasBeenAnswered'] as bool? ?? false,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'questionType': _$QuestionTypeEnumMap[instance.questionType],
      'hasBeenAnswered': instance.hasBeenAnswered,
    };

const _$QuestionTypeEnumMap = {
  QuestionType.maths: 'maths',
  QuestionType.english: 'english',
};
