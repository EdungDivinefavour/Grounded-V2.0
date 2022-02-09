// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Math _$MathFromJson(Map<String, dynamic> json) => Math(
      mathType: $enumDecode(_$MathTypeEnumMap, json['mathType']),
    )
      ..displayedQuestion = json['displayedQuestion'] as String?
      ..pickedAnswer = json['pickedAnswer'] as String?
      ..correctAnswer = json['correctAnswer'] as String?;

Map<String, dynamic> _$MathToJson(Math instance) => <String, dynamic>{
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'mathType': _$MathTypeEnumMap[instance.mathType],
    };

const _$MathTypeEnumMap = {
  MathType.addition: 'addition',
  MathType.subtraction: 'subtraction',
  MathType.multiplication: 'multiplication',
  MathType.division: 'division',
};
