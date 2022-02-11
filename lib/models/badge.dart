import 'package:grounded/constants/enums/badge_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'badge.g.dart';

@JsonSerializable(explicitToJson: true)
class Badge {
  final String name;
  final BadgeType type;
  final int dateEarned;

  Badge({required this.name, required this.type, required this.dateEarned});

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}
