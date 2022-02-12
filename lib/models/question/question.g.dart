// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      questionCategory:
          $enumDecode(_$QuestionCategoryEnumMap, json['questionCategory']),
      displayedQuestion: json['displayedQuestion'] as String?,
      pickedAnswer: json['pickedAnswer'] as String?,
      correctAnswer: json['correctAnswer'] as String?,
      completedTimestap: json['completedTimestap'] as int?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'questionCategory': _$QuestionCategoryEnumMap[instance.questionCategory],
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'completedTimestap': instance.completedTimestap,
    };

const _$QuestionCategoryEnumMap = {
  QuestionCategory.maths: 'maths',
  QuestionCategory.english: 'english',
};
