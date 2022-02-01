// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grounded_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroundedTask _$GroundedTaskFromJson(Map<String, dynamic> json) => GroundedTask(
      creationTime: json['creationTime'] as int,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroundedTaskToJson(GroundedTask instance) =>
    <String, dynamic>{
      'creationTime': instance.creationTime,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };
