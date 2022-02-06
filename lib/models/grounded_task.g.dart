// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grounded_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroundedTask _$GroundedTaskFromJson(Map<String, dynamic> json) => GroundedTask(
      id: json['id'] as String,
      name: json['name'] as String,
      parentID: json['parentID'] as String,
      childID: json['childID'] as String,
      creationTimestamp: json['creationTimestamp'] as int,
      expectedCompletionTimestamp: json['expectedCompletionTimestamp'] as int,
      questionTypeToCreate:
          $enumDecode(_$QuestionTypeEnumMap, json['questionTypeToCreate']),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroundedTaskToJson(GroundedTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentID': instance.parentID,
      'childID': instance.childID,
      'creationTimestamp': instance.creationTimestamp,
      'expectedCompletionTimestamp': instance.expectedCompletionTimestamp,
      'questionTypeToCreate':
          _$QuestionTypeEnumMap[instance.questionTypeToCreate],
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

const _$QuestionTypeEnumMap = {
  QuestionType.maths: 'maths',
  QuestionType.english: 'english',
};
