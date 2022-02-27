import 'package:grounded/constants/enums/badge_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'badge.g.dart';

@JsonSerializable(explicitToJson: true)
class Badge {
  final BadgeType type;
  Badge({required this.type});

  String get name =>
      '${type.value[0].toUpperCase()}${type.value.substring(1).toLowerCase()}';

  String get image => 'badges/${type.value}.png';

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}
