import 'package:json_annotation/json_annotation.dart';

part 'grounded_notification.g.dart';

@JsonSerializable(explicitToJson: true)
class GroundedNotification {
  final String title;
  final String body;
  final int creationTimeStamp;

  GroundedNotification({
    required this.title,
    required this.body,
    required this.creationTimeStamp,
  });

  factory GroundedNotification.fromJson(Map<String, dynamic> json) =>
      _$GroundedNotificationFromJson(json);

  static List<GroundedNotification> fromJsonList(List<dynamic>? list) =>
      list?.map((e) => GroundedNotification.fromJson(e)).toList() ?? [];

  Map<String, dynamic> toJson() => _$GroundedNotificationToJson(this);
}
