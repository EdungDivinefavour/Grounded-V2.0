// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Achievement _$AchievementFromJson(Map<String, dynamic> json) => Achievement(
      title: json['title'] as String,
      badge: Badge.fromJson(json['badge'] as Map<String, dynamic>),
      dateEarned: json['dateEarned'] as int,
    );

Map<String, dynamic> _$AchievementToJson(Achievement instance) =>
    <String, dynamic>{
      'title': instance.title,
      'badge': instance.badge.toJson(),
      'dateEarned': instance.dateEarned,
    };
