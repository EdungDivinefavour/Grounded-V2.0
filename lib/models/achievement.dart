import 'package:grounded/models/badge.dart';
import 'package:json_annotation/json_annotation.dart';

part 'achievement.g.dart';

@JsonSerializable(explicitToJson: true)
class Achievement {
  final String title;
  final Badge badge;
  final int dateEarned;

  Achievement({
    required this.title,
    required this.badge,
    required this.dateEarned,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
  Map<String, dynamic> toJson() => _$AchievementToJson(this);
}
