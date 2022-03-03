// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      text: json['text'] as String,
      type: $enumDecode(_$WordTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'type': _$WordTypeEnumMap[instance.type],
      'text': instance.text,
    };

const _$WordTypeEnumMap = {
  WordType.animal: 'animal',
  WordType.music: 'music',
  WordType.sport: 'sport',
  WordType.color: 'color',
  WordType.number: 'number',
  WordType.food: 'food',
  WordType.nature: 'nature',
  WordType.climate: 'climate',
  WordType.fruits: 'fruits',
  WordType.place: 'place',
  WordType.vehicle: 'vehicle',
  WordType.household: 'household',
  WordType.thing: 'thing',
  WordType.person: 'person',
};
