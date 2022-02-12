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
      questionCategoryToCreate: $enumDecode(
          _$QuestionCategoryEnumMap, json['questionCategoryToCreate']),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      mathTypeToCreate:
          $enumDecodeNullable(_$MathTypeEnumMap, json['mathTypeToCreate']),
      englishTypeToCreate: $enumDecodeNullable(
          _$EnglishTypeEnumMap, json['englishTypeToCreate']),
    );

Map<String, dynamic> _$GroundedTaskToJson(GroundedTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentID': instance.parentID,
      'childID': instance.childID,
      'creationTimestamp': instance.creationTimestamp,
      'expectedCompletionTimestamp': instance.expectedCompletionTimestamp,
      'questionCategoryToCreate':
          _$QuestionCategoryEnumMap[instance.questionCategoryToCreate],
      'mathTypeToCreate': _$MathTypeEnumMap[instance.mathTypeToCreate],
      'englishTypeToCreate': _$EnglishTypeEnumMap[instance.englishTypeToCreate],
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

const _$QuestionCategoryEnumMap = {
  QuestionCategory.maths: 'maths',
  QuestionCategory.english: 'english',
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
