// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      text: json['text'] as String,
      type: $enumDecode(_$EnglishSubTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'type': _$EnglishSubTypeEnumMap[instance.type],
      'text': instance.text,
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
