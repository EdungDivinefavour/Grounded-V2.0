// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      text: json['text'] as String,
      imageUrl: json['imageUrl'] as String,
      wordType: $enumDecode(_$WordTypeEnumMap, json['wordType']),
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'wordType': _$WordTypeEnumMap[instance.wordType],
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
  WordType.country: 'country',
  WordType.vehicle: 'vehicle',
  WordType.household: 'household',
};
