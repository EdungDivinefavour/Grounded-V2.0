// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'math.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Math _$MathFromJson(Map<String, dynamic> json) => Math(
      mathType: $enumDecode(_$MathTypeEnumMap, json['mathType']),
      mathSubType: $enumDecode(_$MathSubTypeEnumMap, json['mathSubType']),
      subjectType:
          $enumDecodeNullable(_$SubjectTypeEnumMap, json['subjectType']) ??
              SubjectType.maths,
      displayedQuestion: json['displayedQuestion'] as String?,
      pickedAnswer: json['pickedAnswer'] as String?,
      completedTimestamp: json['completedTimestamp'] as int?,
    )
      ..suggestedAnswers = (json['suggestedAnswers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..word = json['word'] as String?
      ..timeSpentOnQuestion = json['timeSpentOnQuestion'] as int
      ..numberOfTimesAttempted = json['numberOfTimesAttempted'] as int
      ..hasBeenAnswered = json['hasBeenAnswered'] as bool
      ..correctAnswer = json['correctAnswer'] as String?;

Map<String, dynamic> _$MathToJson(Math instance) => <String, dynamic>{
      'suggestedAnswers': instance.suggestedAnswers,
      'word': instance.word,
      'timeSpentOnQuestion': instance.timeSpentOnQuestion,
      'numberOfTimesAttempted': instance.numberOfTimesAttempted,
      'hasBeenAnswered': instance.hasBeenAnswered,
      'subjectType': _$SubjectTypeEnumMap[instance.subjectType],
      'displayedQuestion': instance.displayedQuestion,
      'pickedAnswer': instance.pickedAnswer,
      'correctAnswer': instance.correctAnswer,
      'completedTimestamp': instance.completedTimestamp,
      'mathType': _$MathTypeEnumMap[instance.mathType],
      'mathSubType': _$MathSubTypeEnumMap[instance.mathSubType],
    };

const _$MathTypeEnumMap = {
  MathType.addition: 'addition',
  MathType.subtraction: 'subtraction',
  MathType.multiplication: 'multiplication',
  MathType.division: 'division',
};

const _$MathSubTypeEnumMap = {
  MathSubType.addDoubles: 'addDoubles',
  MathSubType.addTwoNumbersMakeTen: 'addTwoNumbersMakeTen',
  MathSubType.addThreeNumbers: 'addThreeNumbers',
  MathSubType.subtractDoubles: 'subtractDoubles',
  MathSubType.divideDoubles: 'divideDoubles',
  MathSubType.findMissingNumber: 'findMissingNumber',
  MathSubType.oneX: 'oneX',
  MathSubType.twoX: 'twoX',
  MathSubType.threeX: 'threeX',
  MathSubType.fourX: 'fourX',
  MathSubType.fiveX: 'fiveX',
  MathSubType.sixX: 'sixX',
  MathSubType.sevenX: 'sevenX',
  MathSubType.eightX: 'eightX',
  MathSubType.nineX: 'nineX',
  MathSubType.tenX: 'tenX',
};

const _$SubjectTypeEnumMap = {
  SubjectType.maths: 'maths',
  SubjectType.english: 'english',
};
