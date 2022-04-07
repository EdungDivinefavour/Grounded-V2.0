// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grounded_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroundedTask _$GroundedTaskFromJson(Map<String, dynamic> json) => GroundedTask(
      id: json['id'] as String,
      parentID: json['parentID'] as String,
      childID: json['childID'] as String,
      childName: json['childName'] as String,
      childPhotoUrl: json['childPhotoUrl'] as String,
      creationTimestamp: json['creationTimestamp'] as int,
      expectedCompletionTimestamp: json['expectedCompletionTimestamp'] as int,
      subjectType: $enumDecode(_$SubjectTypeEnumMap, json['subjectType']),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfQuestionsToCreate: json['numberOfQuestionsToCreate'] as int?,
      mathTypeToCreate:
          $enumDecodeNullable(_$MathTypeEnumMap, json['mathTypeToCreate']),
      mathSubTypeToCreate: $enumDecodeNullable(
          _$MathSubTypeEnumMap, json['mathSubTypeToCreate']),
      englishTypeToCreate: $enumDecodeNullable(
          _$EnglishTypeEnumMap, json['englishTypeToCreate']),
      englishSubTypeToCreate: $enumDecodeNullable(
          _$EnglishSubTypeEnumMap, json['englishSubTypeToCreate']),
    );

Map<String, dynamic> _$GroundedTaskToJson(GroundedTask instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parentID': instance.parentID,
      'childID': instance.childID,
      'childName': instance.childName,
      'childPhotoUrl': instance.childPhotoUrl,
      'creationTimestamp': instance.creationTimestamp,
      'expectedCompletionTimestamp': instance.expectedCompletionTimestamp,
      'subjectType': _$SubjectTypeEnumMap[instance.subjectType],
      'numberOfQuestionsToCreate': instance.numberOfQuestionsToCreate,
      'mathTypeToCreate': _$MathTypeEnumMap[instance.mathTypeToCreate],
      'mathSubTypeToCreate': _$MathSubTypeEnumMap[instance.mathSubTypeToCreate],
      'englishTypeToCreate': _$EnglishTypeEnumMap[instance.englishTypeToCreate],
      'englishSubTypeToCreate':
          _$EnglishSubTypeEnumMap[instance.englishSubTypeToCreate],
      'questions': instance.questions.map((e) => e.toJson()).toList(),
    };

const _$SubjectTypeEnumMap = {
  SubjectType.maths: 'maths',
  SubjectType.english: 'english',
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

const _$EnglishTypeEnumMap = {
  EnglishType.general: 'general',
};

const _$EnglishSubTypeEnumMap = {
  EnglishSubType.animal: 'animal',
  EnglishSubType.music: 'music',
  EnglishSubType.sport: 'sport',
  EnglishSubType.color: 'color',
  EnglishSubType.number: 'number',
  EnglishSubType.food: 'food',
  EnglishSubType.nature: 'nature',
  EnglishSubType.climate: 'climate',
  EnglishSubType.fruits: 'fruits',
  EnglishSubType.place: 'place',
  EnglishSubType.vehicle: 'vehicle',
  EnglishSubType.household: 'household',
  EnglishSubType.thing: 'thing',
  EnglishSubType.person: 'person',
};
