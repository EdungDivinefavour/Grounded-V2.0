// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      subject: $enumDecode(_$SubjectTypeEnumMap, json['subject']),
      displayedQuestion: json['displayedQuestion'] as String?,
      pickedAnswer: json['pickedAnswer'] as String?,
      correctAnswer: json['correctAnswer'] as String?,
      completedTimestap: json['completedTimestap'] as int?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'subject': _$SubjectTypeEnumMap[instance.subject],
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'completedTimestap': instance.completedTimestap,
    };

const _$SubjectTypeEnumMap = {
  SubjectType.maths: 'maths',
  SubjectType.english: 'english',
};
