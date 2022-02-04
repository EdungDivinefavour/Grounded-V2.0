import 'package:grounded/models/badge.dart';
import 'package:json_annotation/json_annotation.dart';

part 'achievement.g.dart';

@JsonSerializable(explicitToJson: true)
class Achievement {
  final String title;
  final Badge badge;

  Achievement({required this.title, required this.badge});

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
  Map<String, dynamic> toJson() => _$AchievementToJson(this);
}
