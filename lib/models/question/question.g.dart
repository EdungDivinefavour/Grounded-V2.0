// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      questionCategory:
          $enumDecode(_$QuestionCategoryEnumMap, json['questionCategory']),
      questionType: $enumDecode(_$QuestionTypeEnumMap, json['questionType']),
      hasBeenAnswered: json['hasBeenAnswered'] as bool? ?? false,
      displayedQuestion: json['displayedQuestion'] as String?,
      pickedAnswer: json['pickedAnswer'] as String?,
      correctAnswer: json['correctAnswer'] as String?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'questionCategory': _$QuestionCategoryEnumMap[instance.questionCategory],
      'questionType': _$QuestionTypeEnumMap[instance.questionType],
      'hasBeenAnswered': instance.hasBeenAnswered,
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
    };

const _$QuestionCategoryEnumMap = {
  QuestionCategory.maths: 'maths',
  QuestionCategory.english: 'english',
};

const _$QuestionTypeEnumMap = {
  QuestionType.generalEnglish: 'generalEnglish',
  QuestionType.addition: 'addition',
  QuestionType.subtraction: 'subtraction',
  QuestionType.multiplication: 'multiplication',
  QuestionType.division: 'division',
};
