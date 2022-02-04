// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
      name: json['name'] as String,
      type: $enumDecode(_$BadgeTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'name': instance.name,
      'type': _$BadgeTypeEnumMap[instance.type],
    };

const _$BadgeTypeEnumMap = {
  BadgeType.champion: 'champion',
  BadgeType.learner: 'learner',
  BadgeType.expert: 'expert',
  BadgeType.student: 'student',
  BadgeType.veteran: 'veteran',
};
